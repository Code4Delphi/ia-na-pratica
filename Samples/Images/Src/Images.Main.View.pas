unit Images.Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.Imaging.pngimage,
  jpeg,
  TMS.MCP.CustomComponent,
  TMS.MCP.CloudBase,
  TMS.MCP.CloudAI;

type
  TImagesMainView = class(TForm)
    pnBoth: TPanel;
    Panel1: TPanel;
    pnImagesBack: TPanel;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    pnImagem01: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    btnLoadImage1: TButton;
    OpenDialog1: TOpenDialog;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    Panel3: TPanel;
    gBoxQuestion: TGroupBox;
    mmQuestion: TMemo;
    Label1: TLabel;
    cBoxIAService: TComboBox;
    btnExecute: TBitBtn;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnLoadImage1Click(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject;
      AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer; AHttpResult: string);
  private
    FFileNameImg1: string;
    FFileNameImg2: string;
  public

  end;

var
  ImagesMainView: TImagesMainView;

implementation

{$R *.dfm}

procedure TImagesMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  TMSMCPCloudAI1.APIKeys.LoadFromFile('..\..\Files\aikeys.cfg', 'PasswordTest');
  cBoxIAService.Items.Assign(TMSMCPCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 7;
end;

procedure TImagesMainView.btnLoadImage1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then
    Exit;

  FFileNameImg1 := OpenDialog1.FileName;
  Image1.Picture.LoadFromFile(FFileNameImg1);
end;

procedure TImagesMainView.btnExecuteClick(Sender: TObject);
begin
  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);

  TMSMCPCloudAI1.Files.Clear;
  TMSMCPCloudAI1.AddFile(FFileNameImg1, aiftImage);

  TMSMCPCloudAI1.Context := mmQuestion.Lines;
  TMSMCPCloudAI1.Execute;

  ProgressBar1.State := pbsNormal;
end;

procedure TImagesMainView.TMSMCPCloudAI1Executed(Sender: TObject;
  AResponse: TTMSMCPCloudAIResponse;
  AHttpStatusCode: Integer; AHttpResult: string);
begin
  ProgressBar1.State := pbsPaused;
  mmResponse.Lines := AResponse.Content;
end;

end.
