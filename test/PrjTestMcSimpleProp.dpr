program PrjTestMcSimpleProp;

uses
  Vcl.Forms,
  FoMainDx in 'FoMainDx.pas' {FormMain},
  McSimpleProp in '..\src\McSimpleProp.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
