unit ToolSetCEP;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudAI,
  TMS.MCP.CloudBase;

type
  TToolSetCEP = class(TTMSMCPCloudAIToolSet)
  private
    procedure ToolSetCepExecute(Sender: TObject; Args: TJSONObject; var Result: string);
    function GetEndereco(const ACEP: string): string;
  protected
    procedure DefineTools; override;
  end;

implementation

procedure TToolSetCEP.DefineTools;
var
  LTool: TTMSMCPCloudAITool;
  LParam: TTMSMCPCloudAIParameter;
begin
  BeginUpdate;

  LTool := Tools.Add;
  LTool.Name := 'RetornaEndereco';
  LTool.Description := 'Retorna o endereço do CEP informado';
  LTool.OnExecute := Self.ToolSetCepExecute;

  LParam := LTool.Parameters.Add;
  LParam.Name := 'CEP';
  LParam.Description := 'CEP a ser utilizado para buscar endereço';

  EndUpdate;
end;

procedure TToolSetCEP.ToolSetCepExecute(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LCep: string;
begin
  LCep := Args.GetValue<string>('CEP', '');
  Result := Self.GetEndereco(LCep);
end;

function TToolSetCEP.GetEndereco(const ACEP: string): string;
var
  LRequest: TTMSMCPCloudBase;
  LResult: string;
begin
  LRequest := TTMSMCPCloudBase.Create;
  try
    LRequest.Request.Host := 'https://viacep.com.br/ws/';
    LRequest.Request.Path := Format('%s/json', [ACEP.Replace('-', '', [])]);

    LRequest.ExecuteRequest(
      procedure(const ARequestResult:TTMSMCPCloudBaseRequestResult)
      begin
        LResult := ARequestResult.ResultString;
      end, nil, False);

    Result := LResult;
  finally
    LRequest.Free;
  end;
end;

end.
