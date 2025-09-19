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
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
      AHttpStatusCode: Integer; AHttpResult: string);
    procedure TMSMCPCloudAIToolSet1Tools0Execute(Sender: TObject; Args: TJSONObject; var Result: string);
  private
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
  cBoxIAService.Items.Assign(TMSMCPCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 0;
end;

procedure TToolsetsRADMainView.btnExecuteClick(Sender: TObject);
begin
  mmResponse.Text := 'Processando...';

  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);
  TMSMCPCloudAI1.Context := mmQuestion.Lines;
  TMSMCPCloudAI1.Execute();
  ProgressBar1.State := pbsNormal;
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

end.
