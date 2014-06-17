
unit UCMDPACTION ;

{$mode objfpc}
{$H+}
{$m+}          // directive to be used for using constructor
{$MODESWITCH advancedrecords}     // note: in mode objfpc the modeswitch advancedrecords is needed

interface

type
    CMDPACTION = class

      public
         function Delete:boolean;
         function IsValid():boolean;
         function GetIndofMostLikelyOutcome():integer;
         function GetIndofOutcome(OutcomeID: integer):integer;
         function DeleteAllOutcomes():boolean;
      public
         constructor cCMDPACTION(ID:integer; sourcestateid:integer);
         destructor dCMDPACTION;
      public
          procedure AddOutcome( OutcomeStateID:integer; OutcomeCost: integer; OutcomeProb: Double);
          procedure DisableMemCheck();
          procedure EnableMemCheck();

          // Não jefferson não estou errando é porque o  OPERADOR está recebendo a classe CMDPACTION
          class operator = (const V,@rhsaction:CMDPACTION):boolean;
     end;


   var
    oind : integer;
    StateArray:^CMDPACTION;
    RecordPtr : ^CMDPACTION;
    action : ^CMDPACTION;
    ActionID:integer;
    SourceStateID:integer;
    SuccsID:array of integer;
    Costs:array of integer;
    SuccsProb: array of double;
     PlannerSpecificData:  pointer;


   CONST
    EPS_ERROR  = 0.000001;

implementation

{$R *.dfm} // Include form   DFM ou LFM ?

class operator CMDPACTION.=const V,@rhsaction:CMDPACTION):boolean;

begin

      ActionID  := rhsaction.ActionID;
 result := true;
end;

function CMDPACTION.Delete:boolean;
begin
       SetLength(SuccsID,0);
       SetLength(Costs,0);
       SetLength(SuccsProb, 0);
       result := true;
end;

function CMDPACTION.DeleteAllOutcomes():boolean;
begin
     SetLength(SuccsID,0);
     SetLength(Costs,0);
     SetLength(SuccsProb,0);
     result := true;
end;


function CMDPACTION.IsValid():boolean;
var
   prob: double;
   i:   integer;
   intSuccesProb:integer;
Begin
   Prob := 0;
   intSuccesProb := Length( SuccsProb);
      for i := 0 to intSuccesProb  do
        Begin
           Prob := Prob+ SuccsProb[i]
        end;
    result := (Abs(Prob-1.0) < EPS_ERROR);
end;

procedure CMDPACTION.EnableMemCheck();
begin
      // é uma função que não tem "tradução" olha na biblioteca UTILS, linha 54
end;

procedure CMDPACTION.DisableMemCheck();
begin
     // é uma função que não tem "tradução" olha na biblioteca UTILS, linha 37
end;

procedure CMDPACTION.AddOutcome( OutcomeStateID:integer; OutcomeCost: integer; OutcomeProb: Double);
begin
     {$IFDEF MEM_CHECK}
             DisableMemCheck();
             //SuccsID.push_back(OutcomeStateID);
             SetLength(SuccsID, 0);
             //Costs.push_back(OutcomeCost);
             SetLength(SuccsID, 0);
             //SuccsProb.push_back(OutcomeProb);
             SetLength(SuccsID, 0);
      {$IFDEF MEM_CHECK}
             EnableMemCheck();
      {$ENDIF}
              // Essas diretivas estão corretas ?
      {$ENDIF}
end;

function CMDPACTION.GetIndofMostLikelyOutcome():integer;
var
   HighestProb :double ;
   mlind: integer;

begin
     HighestProb := 0;
     mlind := -1;


     for oind := 0 to  Length(SuccsID) do // ponteiro THIS
     Begin
         if(SuccsProb[oind] >= HighestProb) then
         Begin
              mlind := oind;
              HighestProb := SuccsProb[oind]; // ponteiro THIS
         end;
     end;
     result:=mlind;
end;

function CMDPACTION.GetIndofOutcome(OutcomeID: integer):integer;
begin

     for oind := 0 to  Length(SuccsID) do // ponteiro this
     begin
	if(SuccsID[oind] = OutcomeID) then
	begin
	     result:= oind;
	end;
     end;
     result := -1;
end;

constructor CMDPACTION.cCMDPACTION(ID:integer; sourcestateid:integer);
begin
     ActionID := ID;
     SourceStateID := sourcestateid;     // 1
     PlannerSpecificData := nil;
end;

destructor CMDPACTION.dCMDPACTION;
begin
     if(PlannerSpecificData <> nil )  then
        begin
	     //SBPL_FPRINTF(stderr, "ERROR: state deletion: planner specific data is not deleted\n");
	     //throw new SBPL_Exception();
        end;
end;

end.

