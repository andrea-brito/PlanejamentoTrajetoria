
unit ucmdpstate ;

{$mode objfpc}
{$H+}
{$m+}          // directive to be used for using constructor
{$MODESWITCH advancedrecords}     // note: in mode objfpc the modeswitch advancedrecords is needed

interface

uses Classes, SysUtils,StdCtrls,UCMDPACTION;
 type

     CMDPSTATE = class

      public
        // function


        function Delete:boolean;
	function ContainsPred( stateID: integer):boolean;
	function  AddPred( stateID: integer ):boolean;
	function RemovePred( stateID: integer): boolean;
	function RemoveAllActions: boolean;
    //>>>> CMDPACTION* AddAction(int ID);
    function GetAction(actionID:integer) : CMDPACTION;
	/// >>>
         constructor cCMDPSTATE(ID: integer);
         destructor dCMDPSTATE;

            // Não jefferson não estou errando é porque o  OPERADOR está recebendo a classe CMDPstate
           class operator = (const V,@rhsaction:CMDPSTATE ):boolean;

          end;
    var
         StateID: integer;

         //vector<int> PredsID:integer;
 	PredsID: array of integer;
	//void* PlannerSpecificData;
	PlannerSpecificData: Pointer;
        //vector<CMDPACTION*> Actions;
         Actions: array of integer;



implementation

//----------------------------------------------------------------------

//----------------------------MDPSTATE class functions---------------

function CMDPSTATE.Delete(): boolean;

Begin
	  action : ^CMDPACTION;

	if(PlannerSpecificData <> NULL)     then
         begin
	//	SBPL_ERROR("ERROR deleting state: planner specific data is not deleted\n");
       //	throw new SBPL_Exception();


	//delete predecessors array
	PredsID.clear;

       end;

        //delete actions array
	while(Length(Actions) > 0)

		action = Actions[Length(Actions)-1];
		 SetLength(Actions,Length(Actions)-1);

		action^.Delete();
		action.Free;

            result := true;
  end;



function CMDPSTATE.RemoveAllActions: boolean;
begin

          action: ^CMDPACTION;

	//delete actions array
	while(Lengt(Actions) > 0)  do
	begin
		action := Actions[Length(Actions-1)];
               SetLength(Actions,Length(Actions-1));


		action^.Delete();
		action.Free;
	end;

     result:=true;
end;




function CMDPSTATE.RemovePred( stateID: integer): boolean;
begin

	for(int i = 0 to  Length(redsID)) do
	begin
          //VETOR .at
	{	if(this->PredsID.at(i) = stateID)
		begin
			this->PredsID.at(i) = this->PredsID.at(this->PredsID.size()-1);
			this->PredsID.pop_back();
			return true;
                end;
                 }
	end;

     result:=true;
        end;
class operator CMDPSTATE .=const V,@rhsaction:CMDPSTATE ):boolean;


begin

     Self.ActionID  := rhsaction.ActionID;
 result := true;

end;





function CMDPSTATE.AddPred( stateID: integer ):boolean;
begin
     //add the predecessor
	if(not ContainsPred(stateID)) then
        begin
        {$IFDEF MEM_CHECK}
	DisableMemCheck();
        {$ENDIF}

     SetLength(PredsID,Length(stateID-1));

    {$IFDEF MEM_CHECK}
	EnableMemCheck();
        {$ENDIF}
	end;
    result:= true;
end;

   function CMDPSTATE.ContainsPred( stateID: integer):boolean;
   begin

              for(i = 0; to i < Lengt(PredsID)) do
	begin
		if(PredsID[i] = stateID) then
			result := true;
        end;

       	result:= true;
	end;

    function CMDPSTATE.GetAction(actionID:integer ) : CMDPACTION;
begin
      for(int i = 0; i < (int)Actions.size(); i++)
	begin
		if(Actions[i]^.ActionID = actionID)  then
		result :=Actions[i];
	end;

	result := nil;

  end;


constructor CMDPSTATE.cCMDPSTATE( ID:integer);
   begin
           	StateID := ID;
		PlannerSpecificData := nil;
 end;

destructor CMDPSTATE.dCMDPSTATE;
begin
     if(PlannerSpecificData <> Nil) then
		begin
			//SBPL_FPRINTF(stderr, "ERROR: state deletion: planner specific data is not deleted\n");
			//throw new SBPL_Exception();
		end;
end;




end.


