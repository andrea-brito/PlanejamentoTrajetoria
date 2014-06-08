
unit UCMDPACTION ;

{$mode objfpc}
{$H+}
{$m+}          // directive to be used for using constructor
{$MODESWITCH advancedrecords}     // note: in mode objfpc the modeswitch advancedrecords is needed

interface

uses Classes, SysUtils,StdCtrls;

type
    CMDPACTION = class

      public
          function Delete:boolean;
          function IsValid():boolean;
          procedure AddOutcome( OutcomeStateID:integer; OutcomeCost: integer; OutcomeProb: Double);
          function GetIndofMostLikelyOutcome():integer;
         function GetIndofOutcome(OutcomeID: integer):integer;
         function DeleteAllOutcomes():boolean;
         //operator

        constructor cCMDPACTION(ID:integer; sourcestateid:integer);
        destructor dCMDPACTION;

 procedure DisableMemCheck();
 procedure EnableMemCheck();


 //operators


     class operator = (const V,@rhsaction:CMDPACTION):boolean;

   end;


   var

    contador1,contador2,contador3,contador4,contador5,contador6,i,j:integer;
      oind : integer;
        tamanho:integer;
     StateArray:^CMDPACTION;
     RecordPtr : ^CMDPACTION;
      action : ^CMDPACTION;
        //int ActionID;
	 ActionID:integer;
	//int SourceStateID;
	SourceStateID:integer;
	//vector<int> SuccsID;
	SuccsID:array of integer;
	//vector<int> Costs;
	Costs:array of integer;
	//vector<float>
         SuccsProb: array of double;
         //int StateID;


        CONST
         EPS_ERROR  = 0.000001;


implementation
{$R *.dfm} // Include form


class operator CMDPACTION.=const V,@rhsaction:CMDPACTION):boolean;
    //ActionID := Addr(self);
begin

      Self.ActionID  := rhsaction.ActionID;
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

       end;
        procedure CMDPACTION.DisableMemCheck();
       begin

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
        {$ENDIF}


     end;

         function CMDPACTION.GetIndofMostLikelyOutcome():integer;
           var
          HighestProb :double ;
          mlind: integer;

         begin

        HighestProb := 0;

        mlind := -1;
           tamanho := Length(SuccsID);

       { for oind := 0 to oind < self(tamanho) do // ponteiro THIS
        Begin
                if(self.SuccsProb[oind] >= HighestProb) then
                Begin
                        mlind := oind;
                        HighestProb := self.SuccsProb[oind]; // ponteiro THIS
                end;
        end;          }
         result:=mlind;
         end;

         function CMDPACTION.GetIndofOutcome(OutcomeID: integer):integer;

         begin
                 tamanho:=  Length(SuccsID);
                	for oind := 0 to tamanho do // ponteiro this
	begin
	{	if( self.SuccsID)[oind] = OutcomeID)    then
		begin
			result:= oind;
		end; ^}
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
