unit CMDP;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,StdCtrls,Ucmdpstate;

type
    tCMDP = class
       //data
public
        //>>>> vector<CMDPACTION*> Actions;


//constructors
public
       constructor cCMDP();
       destructor dCMDP;
       //functions
public
 function empty():boolean;
 function full():boolean;
 //creates numofstates states. Their ids are their orderings for Original, Thresholded & Search MDPs
 function Create(numofstates: integer ):boolean;
 function Delete(): boolean;
 //PRINT imprimir na tela  void Print(FILE* fOut);


      end;


implementation

     function tCMDP.empty():boolean;
     begin
       result:=true;
       end;
 function tCMDP.full():boolean;
       begin
          result:=true;
       end;


function tCMDP.Create(numofstates: integer ):boolean;
begin
    result:=true;
       end;
 function tCMDP.Delete(): boolean;
    begin
               result:=true;
       end;
constructor tCMDP.cCMDP();
begin

       end;

     destructor tCMDP.dCMDP;
     begin
       end;

end.

