program TokenUsageTracking;

uses
  Vcl.Forms,
  TokenUsageTracking.Main.View in 'Src\TokenUsageTracking.Main.View.pas' {TokenUsageTrackingMainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTokenUsageTrackingMainView, TokenUsageTrackingMainView);
  Application.Run;
end.
