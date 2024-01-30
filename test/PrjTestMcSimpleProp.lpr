program PrjTestMcSimpleProp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, FoMainLz, McSimpleProp;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='prjtestmcsimpleprop';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.

