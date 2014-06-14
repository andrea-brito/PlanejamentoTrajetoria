program RSTAR;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  {Forms,} UCMDPACTION,Ucmdpstate,Urstar, UMDP, CMDP;

{$R *.res}

begin
  //RequireDerivedFormResource := True;
  //Application.Initialize;
  //Application.CreateForm(TForm1, Form1);
  //Application.Run;
end.

