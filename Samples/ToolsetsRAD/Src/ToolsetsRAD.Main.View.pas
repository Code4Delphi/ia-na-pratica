unit ToolsetsRAD.Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.JSON,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  TMS.MCP.CustomComponent,
  TMS.MCP.Server,
  TMS.MCP.CloudAI,
  TMS.MCP.CloudBase;

type
  TMyToolSet = class(TTMSMCPCloudAIToolSet)
  protected
    procedure DefineTools; override;
  end;

  TToolsetsRADMainView = class(TForm)
    pnTop: TPanel;
    Label1: TLabel;
    cBoxIAService: TComboBox;
    pnBoth: TPanel;
    gBoxQuestion: TGroupBox;
    mmQuestion: TMemo;
    Panel1: TPanel;
    btnExecute: TBitBtn;
    ProgressBar1: TProgressBar;
    Splitter1: TSplitter;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    ToolSetCEP: TTMSMCPCloudAIToolSet;
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
    procedure FormDestroy(Sender: TObject);
    procedure TMSMCPCloudAIToolSet1Tools0Execute(Sender: TObject; Args: TJSONObject; var Result: string);
  private
    FMyToolSet: TMyToolSet;
    function GetEndereco(const ACEP: string): string;
  public

  end;

var
  ToolsetsRADMainView: TToolsetsRADMainView;

implementation

{$R *.dfm}

procedure TToolsetsRADMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  TMSMCPCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');
  TMSMCPCloudAI1.Settings.WebSearch := True;

  cBoxIAService.Items.Assign(TMSMCPCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 0;

  //TTMSMCPCloudAIToolSet.EndUpdate;
  //EndUpdate;
  FMyToolSet := TMyToolSet.Create(nil);
  //FMyToolSet.AI := TMSMCPCloudAI1;
end;

procedure TToolsetsRADMainView.FormDestroy(Sender: TObject);
begin
  FMyToolSet.Free;
end;

procedure TToolsetsRADMainView.btnExecuteClick(Sender: TObject);
begin
  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);

  mmResponse.Text := 'Processando...';
  TMSMCPCloudAI1.Context := mmQuestion.Lines;
  TMSMCPCloudAI1.Execute();
  ProgressBar1.State := pbsNormal;
end;

procedure TToolsetsRADMainView.TMSMCPCloudAIToolSet1Tools0Execute(Sender: TObject; Args: TJSONObject; var Result: string);
var
  LCep: string;
begin
  LCep := Args.GetValue<string>('CEP', '');
  Result := Self.GetEndereco(LCep);
end;

function TToolsetsRADMainView.GetEndereco(const ACEP: string): string;
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

procedure TToolsetsRADMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
  AHttpStatusCode: Integer; AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;

  if AHttpStatusCode <> 200 then
  begin
    mmResponse.Lines.Text := 'HTTP error code: ' + AHttpStatusCode.ToString + sLineBreak + AHttpResult;
    Exit;
  end;

  mmResponse.Lines := AResponse.Content;
end;

{ TMyToolSet }
procedure TMyToolSet.DefineTools;
var
  LTool: TTMSMCPCloudAITool;
  LParam: TTMSMCPCloudAIParameter;
begin
  BeginUpdate;

  LTool := Tools.Add;
  LTool.Name := 'MyFirstProc';
  LTool.Description := 'this is the description that should make the LLM aware of what the tool is used for';

  LParam := LTool.Parameters.Add;
  LParam.Name := 'FirstParam';
  LParam.Description := 'describe here what the first parameter is used for';

  EndUpdate;
end;

end.
