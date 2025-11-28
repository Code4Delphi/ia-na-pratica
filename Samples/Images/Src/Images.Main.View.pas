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
    gBoxQuestion: TGroupBox;
    mmQuestion: TMemo;
    gBoxDefaultsPrompts: TGroupBox;
    pnDefaultsPrompts01: TPanel;
    btnCompareAsImagens: TButton;
    btnDescrevaImagem1: TButton;
    Panel1: TPanel;
    btnExecute: TBitBtn;
    ProgressBar1: TProgressBar;
    pnImagesBack: TPanel;
    gBoxResponse: TGroupBox;
    mmResponse: TMemo;
    Splitter1: TSplitter;
    pnImagem01: TPanel;
    pnImagem02: TPanel;
    Splitter2: TSplitter;
    Panel2: TPanel;
    Panel5: TPanel;
    Image1: TImage;
    Image2: TImage;
    btnLoadImage1: TButton;
    btnLoadImage2: TButton;
    ckAddImagem1: TCheckBox;
    ckAddImagem2: TCheckBox;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    cBoxIAService: TComboBox;
    pnDefaultsPrompts02: TPanel;
    btnVendasPeriodo: TButton;
    TMSMCPCloudAI1: TTMSMCPCloudAI;
    procedure FormCreate(Sender: TObject);
    procedure btnDescrevaImagem1Click(Sender: TObject);
    procedure btnCompareAsImagensClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnLoadImage1Click(Sender: TObject);
    procedure btnLoadImage2Click(Sender: TObject);
    procedure btnVendasPeriodoClick(Sender: TObject);
    procedure TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse; AHttpStatusCode: Integer;
      AHttpResult: string);
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
  //SETA MODELOS QUE SUPORTAM MULTIMODAL
  TMSMCPCloudAI1.Settings.GeminiModel := 'gemini-2.0-flash-exp';
  TMSMCPCloudAI1.Settings.GrokModel := 'grok-2-vision-latest';
  TMSMCPCloudAI1.Settings.MistralModel := 'mistral-small-2503';
  //TMSMCPCloudAI1.Settings.WebSearch := True;

  cBoxIAService.Items.Assign(TMSMCPCloudAI1.GetServices(True));
  cBoxIAService.ItemIndex := 0;
end;

procedure TImagesMainView.btnExecuteClick(Sender: TObject);
begin
  TMSMCPCloudAI1.Service := TTMSMCPCloudAIService(cBoxIAService.Items.Objects[cBoxIAService.ItemIndex]);

  TMSMCPCloudAI1.Files.Clear;
  if ckAddImagem1.Checked then
    TMSMCPCloudAI1.AddFile(FFileNameImg1, aiftImage);

  if ckAddImagem2.Checked then
    TMSMCPCloudAI1.AddFile(FFileNameImg2, aiftImage);

  TMSMCPCloudAI1.Context := mmQuestion.Lines;
  TMSMCPCloudAI1.Execute;

  ProgressBar1.State := pbsNormal;
end;

procedure TImagesMainView.btnLoadImage1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then
    Exit;

  FFileNameImg1 := OpenDialog1.FileName;
  Image1.Picture.LoadFromFile(OpenDialog1.FileName);
end;

procedure TImagesMainView.btnLoadImage2Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then
    Exit;

  FFileNameImg2 := OpenDialog1.FileName;
  Image2.Picture.LoadFromFile(OpenDialog1.FileName);
end;

procedure TImagesMainView.btnDescrevaImagem1Click(Sender: TObject);
begin
  mmQuestion.Text := 'Descreva a imagem';
  ckAddImagem1.Checked := True;
  ckAddImagem2.Checked := False;
end;

procedure TImagesMainView.btnCompareAsImagensClick(Sender: TObject);
begin
  mmQuestion.Text := 'Compare as duas imagens e descreva as diferenças';
  ckAddImagem1.Checked := True;
  ckAddImagem2.Checked := True;
end;

procedure TImagesMainView.btnVendasPeriodoClick(Sender: TObject);
begin
  mmQuestion.Text := 'Extrair o texto da imagem';
  ckAddImagem1.Checked := True;
  ckAddImagem2.Checked := False;
end;

procedure TImagesMainView.TMSMCPCloudAI1Executed(Sender: TObject; AResponse: TTMSMCPCloudAIResponse;
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

end.
