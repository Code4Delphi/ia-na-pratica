program Images;

uses
  Vcl.Forms,
  Images.Main.View in 'Src\Images.Main.View.pas' {ImagesMainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TImagesMainView, ImagesMainView);
  Application.Run;
end.
