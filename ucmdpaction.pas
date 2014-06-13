unit Ucmdpstate ;

{$mode objfpc}{$H+}
{$MODESWITCH advancedrecords}    // note: in mode objfpc the modeswitch advancedrecords is needed
{$X+}

interface

uses Classes, SysUtils,StdCtrls;
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
        //function GetAction(actionID:integer) : CMDPACTION;
	/// >>>
         constructor cCMDPSTATE(ID: integer);
         destructor dCMDPSTATE;



          end;
    var
         StateID: integer;

         //vector<int> PredsID:integer;
 	PredsID: array of integer;
	//void* PlannerSpecificData;
          //void* PlannerSpecificData;
         PlannerSpecificData: Pointer;
        //vector<CMDPACTION*> Actions;



implementation

//----------------------------------------------------------------------

//----------------------------MDPSTATE class functions---------------
function CMDPSTATE.RemoveAllActions: boolean;
begin
     result:=true;
end;


{CMDPSTATE.GetAction(actionID:integer ) : CMDPSTATE;
begin
  end;}

function CMDPSTATE.RemovePred( stateID: integer): boolean;
begin
     result:=true;
end;

function CMDPSTATE.AddPred( stateID: integer ):boolean;
begin
    result:= true;
end;

   function CMDPSTATE.ContainsPred( stateID: integer):boolean;
   begin
       	result:= true;
	end;


function CMDPSTATE.Delete(): boolean;

Begin  {
	CMDPACTION^ action;
          /// The current units form is addressable via the self keyword
          PlannerSpecificData := Addr(self);

           //LOL :=self.PlannerSpecificData ;
	if( PlannerSpecificData <> nil)   then
	begin
		//SBPL_ERROR("ERROR deleting state: planner specific data is not deleted\n");
		writeln('ERROR deleting state: planner specific data is not deleted');
		//throw new SBPL_Exception();
           //delete actions array
	while((int)Actions.size() > 0)

		action = Actions[Actions.size()-1];
		Actions.pop_back();

		action->Delete();
		delete action;

                   }
	result:= true;
	end;
       {
	//delete predecessors array
      //  SetLength(PredsID,0);



        //delete actions array

  begin
	while(  Length(Actions) - 1 >0) do
	begin
		//action := Actions[Actions.size()-1];
		//Actions.pop_back();

		action^.Delete();
		dispose action; //delete
	end;

	result := true;
end;
   }

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
