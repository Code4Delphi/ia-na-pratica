unit Database.Dm;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.Generics.Collections,
  System.Rtti,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  TMS.MCP.Helpers,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite;

type
  TDatabaseDm = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDQuery1: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    function ExecuteQuery(const ASQL: string): TJSONValue;
    function GetTableSchema(const ATableName: string): TJSONValue;
    function QuerySafeguard(const ASQL: string): Boolean;
    procedure ConnectBase;
  public
    procedure RunSQLQuery(Sender: TObject; Args: TJSONObject; var Result: string);
    procedure GetTableList(Sender: TObject; Args: TJSONObject; var Result: string);
    procedure GetTableInfo(Sender: TObject; Args: TJSONObject; var Result: string);
  end;

var
  DatabaseDm: TDatabaseDm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDatabaseDm.DataModuleCreate(Sender: TObject);
begin
  FDConnection1.Params.DriverID := 'SQLite';
  FDConnection1.Params.Database := '..\BD\ReportsHTML.db';
end;

procedure TDatabaseDm.ConnectBase;
begin
  if FDConnection1.Connected then
    Exit;

  try
    FDConnection1.Connected := True;
  except
    on E: Exception do
      RaiseJsonRpcError(TTMSMCPErrorCode.ecOperationFailed,
        'Não foi possível conectar ao banco de dados. A seguinte mensagem indica o possível problema: ' + E.Message);
  end;
end;

procedure TDatabaseDm.RunSQLQuery(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LSQL: string;
  LQueryResult: TJSONValue;
begin
  if Args.Count <= 0 then
    RaiseJsonRpcError(TTMSMCPErrorCode.ecInvalidParams, 'Missing SQL parameter');

  Self.ConnectBase;

  LSQL := Args.GetValue<string>('sql'); //Args[0].AsString;

  LQueryResult := Self.ExecuteQuery(LSQL);

  Result := LQueryResult.ToString;
  LQueryResult.Free;
end;

procedure TDatabaseDm.GetTableList(Sender: TObject; Args: TJSONObject; var Result: string);
var
  //LQuery: TFDQuery;
  LTables: TJSONArray;
begin
  Self.ConnectBase;

  //LQuery := TFDQuery.Create(nil);
  try
    //LQuery.Connection := FDConnection1;

    // SQLite-specific LQuery to get table list
    FDQuery1.SQL.Text := 'SELECT name FROM sqlite_master WHERE type=''table'' AND name NOT LIKE ''sqlite_%''';
    if FDConnection1.Params.DriverID = 'MySQL' then
      FDQuery1.SQL.Text := Format('SELECT table_name as name FROM information_schema.tables WHERE table_schema = "%s"', [FDConnection1.Params.Database])
    else if FDConnection1.Params.DriverID = 'FB' then
      FDQuery1.SQL.Text := 'SELECT RDB$RELATION_NAME as name FROM RDB$RELATIONS  WHERE RDB$SYSTEM_FLAG = 0 AND RDB$RELATION_TYPE = 0';

    try
      FDQuery1.Open;

      LTables := TJSONArray.Create;

      while not FDQuery1.Eof do
      begin
        LTables.Add(FDQuery1.FieldByName('name').AsString);
        FDQuery1.Next;
      end;

      Result := LTables.ToString;
      LTables.Free;
    except
      on E: Exception do
        RaiseJsonRpcError(TTMSMCPErrorCode.ecOperationFailed, 'Error getting table list: ' + E.Message);
    end;
  finally
    FDQuery1.Close;
  end;
end;

procedure TDatabaseDm.GetTableInfo(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LTableName: string;
  LSchema: TJSONValue;
begin
  if Args.Count <= 0 then
    RaiseJsonRpcError(TTMSMCPErrorCode.ecInvalidParams, 'Missing table name parameter');

  Self.ConnectBase;

  LTableName := Args.GetValue<string>('tableName'); //Args[0].AsString;

  LSchema := Self.GetTableSchema(LTableName);
  try
    Result := LSchema.ToString;
  finally
    LSchema.Free;
  end;
end;

function TDatabaseDm.ExecuteQuery(const ASQL: string): TJSONValue;
var
  LQuery: TFDQuery;
  LResultArray: TJSONArray;
  LRowObj: TJSONObject;
  LField: TField;
  I: Integer;
  LIsSelectQuery: Boolean;
  LResultObj: TJSONObject;
  LRowsAffected: Integer;
begin
  Result := nil;

  if not Self.QuerySafeguard(ASQL) then
    RaiseJsonRpcError(TTMSMCPErrorCode.ecInvalidParams, 'Query not allowed for security reasons');

  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FDConnection1;
    LQuery.SQL.Text := ASQL;

    LIsSelectQuery := UpperCase(ASQL.TrimLeft).StartsWith('SELECT');

    try
      if LIsSelectQuery then
      begin
        // Handle SELECT queries with result sets
        LQuery.Open;
        LResultArray := TJSONArray.Create;

        while not LQuery.Eof do
        begin
          LRowObj := TJSONObject.Create;

          for I := 0 to LQuery.FieldCount - 1 do
          begin
            LField := LQuery.Fields[I];

            if LField.IsNull then
              LRowObj.AddPair(LField.FieldName, TJSONNull.Create)
            else
            begin
              case LField.DataType of
                ftString, ftWideString, ftMemo, ftWideMemo:
                  LRowObj.AddPair(LField.FieldName, LField.AsString);
                ftInteger, ftSmallint, ftWord, ftLargeint:
                  LRowObj.AddPair(LField.FieldName, TJSONNumber.Create(LField.AsInteger));
                ftFloat, ftCurrency, ftBCD:
                  LRowObj.AddPair(LField.FieldName, TJSONNumber.Create(LField.AsFloat));
                ftBoolean:
                  LRowObj.AddPair(LField.FieldName, TJSONBool.Create(LField.AsBoolean));
                ftDate, ftDateTime, ftTimeStamp:
                  LRowObj.AddPair(LField.FieldName, FormatDateTime('yyyy-mm-dd hh:nn:ss', LField.AsDateTime));
                else
                  LRowObj.AddPair(LField.FieldName, LField.AsString);
              end;
            end;
          end;

          LResultArray.Add(LRowObj);
          LQuery.Next;
        end;

        Result := LResultArray;
      end
      else
      begin
        // Handle non-SELECT queries (INSERT, UPDATE, DELETE, CREATE, ALTER, DROP)
        LQuery.ExecSQL(ASQL);

        LRowsAffected := 0;
        LResultObj := TJSONObject.Create;
        LResultObj.AddPair('success', TJSONBool.Create(True));
        LResultObj.AddPair('rowsAffected', TJSONNumber.Create(LRowsAffected));
        LResultObj.AddPair('message', Format('Query executed successfully. Rows affected: %d', [LRowsAffected]));

        Result := LResultObj;
      end;
    except
      on E: Exception do
      begin
        RaiseJsonRpcError(TTMSMCPErrorCode.ecOperationFailed, 'Query execution error: ' + E.Message);
      end;
    end;
  finally
    LQuery.Free;
  end;
end;

function TDatabaseDm.GetTableSchema(const ATableName: string): TJSONValue;
var
  LQuery: TFDQuery;
  LResultArray: TJSONArray;
  LColumnObj: TJSONObject;
begin
  Result := nil;
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FDConnection1;

    // SQLite-specific LQuery to get table schema
    LQuery.SQL.Text := 'PRAGMA table_info(' + ATableName + ')';

    try
      LQuery.Open;

      LResultArray := TJSONArray.Create;

      while not LQuery.Eof do
      begin
        LColumnObj := TJSONObject.Create;
        LColumnObj.AddPair('name', LQuery.FieldByName('name').AsString);
        LColumnObj.AddPair('type', LQuery.FieldByName('type').AsString);
        LColumnObj.AddPair('notnull', TJSONBool.Create(LQuery.FieldByName('notnull').AsInteger = 1));
        LColumnObj.AddPair('pk', TJSONBool.Create(LQuery.FieldByName('pk').AsInteger = 1));

        LResultArray.Add(LColumnObj);
        LQuery.Next;
      end;

      Result := LResultArray;
    except
      on E: Exception do
      begin
        RaiseJsonRpcError(TTMSMCPErrorCode.ecOperationFailed, 'Table schema query error: ' + E.Message);
      end;
    end;
  finally
    LQuery.Free;
  end;
end;

function TDatabaseDm.QuerySafeguard(const ASQL: string): Boolean;
var
  LUpperSQL: string;
begin
  // Enhanced safety check to allow data modification with safeguards
  LUpperSQL := UpperCase(ASQL.Trim);

  // Allowed operations
  Result := LUpperSQL.StartsWith('SELECT') or
    LUpperSQL.StartsWith('INSERT') or
    LUpperSQL.StartsWith('UPDATE') or
    LUpperSQL.StartsWith('DELETE') or
    LUpperSQL.StartsWith('CREATE TABLE') or
    LUpperSQL.StartsWith('ALTER TABLE') or
    LUpperSQL.StartsWith('DROP TABLE');

  // Block potentially dangerous operations
  if LUpperSQL.Contains('PRAGMA') or LUpperSQL.Contains('ATTACH') or LUpperSQL.Contains('DETACH') then
    Result := False;
end;

end.
