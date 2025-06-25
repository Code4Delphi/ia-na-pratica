program APIKey;

uses
  Vcl.Forms,
  APIKey.Main.View in 'Src\APIKey.Main.View.pas' {APIKeyMainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAPIKeyMainView, APIKeyMainView);
  Application.Run;
end.
