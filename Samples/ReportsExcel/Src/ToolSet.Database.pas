unit ToolSet.Database;

interface

uses
  System.SysUtils,
  System.Classes,
  Database.Dm,
  TMS.MCP.CloudAI;

type
  TToolSetDatabase = class(TTMSMCPCloudAIToolSet)
  private
  protected
    procedure DefineToolGetTableInfo;
    procedure DefineToolGetTables;
    procedure DefineToolRunQuery;
  public
    procedure DefineTools; override;
  end;

implementation

procedure TToolSetDatabase.DefineTools;
begin
  inherited;
  BeginUpdate;

  Self.DefineToolRunQuery;
  Self.DefineToolGetTables;
  Self.DefineToolGetTableInfo;

  EndUpdate;
end;

procedure TToolSetDatabase.DefineToolRunQuery;
var
  LTool: TTMSMCPCloudAITool;
  LParam: TTMSMCPCloudAIParameter;
begin
  LTool := Tools.Add;
  LTool.Name := 'RunQuery';
  LTool.Description := 'Execute an SQL query';

  LParam := LTool.Parameters.Add;
  LParam.Name := 'sql';
  LParam.&Type := TTMSMCPCloudAIParameterType.ptString;
  LParam.Required := True;
  LParam.Description := 'SQL query to execute (SELECT queries only)';

  LTool.OnExecute := DatabaseDm.RunSQLQuery;
end;

procedure TToolSetDatabase.DefineToolGetTables;
var
  LTool: TTMSMCPCloudAITool;
begin
  LTool := Tools.Add;
  LTool.Name := 'GetTables';
  LTool.Description := 'Get a list of available tables';
  LTool.OnExecute := DatabaseDm.GetTableList;
end;

procedure TToolSetDatabase.DefineToolGetTableInfo;
var
  LTool: TTMSMCPCloudAITool;
  LParam: TTMSMCPCloudAIParameter;
begin
  LTool := Tools.Add;
  LTool.Name := 'GetTableInfo';
  LTool.Description := 'Get information about a table';

  LParam := LTool.Parameters.Add;
  LParam.Name := 'tableName';
  LParam.&Type := TTMSMCPCloudAIParameterType.ptString;
  LParam.Required := True;
  LParam.Description := 'Name of the table to get information about';

  LTool.OnExecute := DatabaseDm.GetTableInfo;
end;

end.
