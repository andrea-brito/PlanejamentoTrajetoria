
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
          procedure AddOutcome(OutcomeStateID:integer; OutcomeCost:integer; OutcomeProb:Double);
          procedure DisableMemCheck();
          procedure EnableMemCheck();

          // Bixo, tu tá errando a mesma coisa, sobrecarga é com registradores, tem que prestar atenção vei.
          //class operator = (const V,@rhsaction:CMDPACTION):boolean;
     end;


   var
    // Esses contadores são para quÊ ? Se incluiu, tu tem que colocar um comentário
    contador1,contador2,contador3,contador4,contador5,contador6,i,j:integer;
    oind : integer;
    tamanho:integer; // Para que serve isso ? Tem o comportamento igual ao do método Length ? Se for diferente explicar.
    StateArray:^CMDPACTION;
    RecordPtr : ^CMDPACTION;
    action : ^CMDPACTION;
    ActionID:integer;
    SourceStateID:integer;
    SuccsID:array of integer;
    Costs:array of integer;
    SuccsProb: array of double;

    // Essas variaveis existem ou não no código ? Se não apague.
    //int StateID;
    //vector<float>

   CONST
    EPS_ERROR  = 0.000001;

implementation

{$R *.dfm} // Include form   DFM ou LFM ?

{class operator CMDPACTION.=const V,@rhsaction:CMDPACTION):boolean;
    //ActionID := Addr(self);
begin

      Self.ActionID  := rhsaction.ActionID;
 result := true;
end;}

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
      // Não faz nada esse método ?
end;

procedure CMDPACTION.DisableMemCheck();
begin
     // Idem anterior ?
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
    // tamanho := Length(SuccsID);       // Isso foi você que incluiu ?

     //for oind := 0 to oind < Length(Self.SuccsID) do | Não estou vendo outro SuccID nesse método
     for oind := 0 to oind < Length(SuccsID) do   // Essa condição de parada, está certa ?
     Begin
         //if(self.SuccsProb[oind] >= HighestProb) then | Não estou vendo outro SuccsProb nesse metodo
         if(SuccsProb[oind] >= HighestProb) then
            Begin
              mlind := oind;
              //HighestProb := self.SuccsProb[oind]; // ponteiro THIS
              HighestProb := SuccsProb[oind]; // ponteiro THIS
         end;
     end;
     result:=mlind;
end;

function CMDPACTION.GetIndofOutcome(OutcomeID: integer):integer;
begin
     //tamanho:=  Length(SuccsID);  Não compreendi se esse aqui era igual ao anterior
     for oind := 0 to tamanho do // ponteiro this
     begin
	//if(Self.SuccsID)[oind] = OutcomeID) then     | Não estou vendo outro SuccsID nesse método
        if(SuccsID)[oind] = OutcomeID) then
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
     if(PlannerSpecificData <> NULL)  then
        begin
	     //SBPL_FPRINTF(stderr, "ERROR: state deletion: planner specific data is not deleted\n");
	     //throw new SBPL_Exception();
        end;
end;

end.
