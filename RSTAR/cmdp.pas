unit CMDP;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils,StdCtrls,Ucmdpstate,UCMDPACTION;

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
 procedure Print( fOut :Textfile);


      end;

             const
               MAXSTATESPACESIZE = 20000000;
implementation

     function tCMDP.empty():boolean;
     begin
                //{	return ((int)StateArray.size() == 0);};
                 result := (Legth(StateArray) = 0) ;

       end;
 function tCMDP.full():boolean;
       begin
          result:=Legth(StateArray) >= MAXSTATESPACESIZE);;
       end;


function tCMDP.Create(numofstates: integer ):boolean;
begin
   CMDPSTATE* state;

	if(numofstates > MAXSTATESPACESIZE)
	{
		SBPL_ERROR("ERROR in Create: maximum MDP size is reached\n");
		throw new SBPL_Exception();
	}

	for i = 0  to i < numofstates; do
	begin
		state :=  CMDPSTATE(-1).create;

                {$IFDEF MEM_CHECK}
                             DisableMemCheck();
                      {$ENDIF}
	SetLength(StateArray,Length(state)-1); //StateArray.push_back(state);

                {$IFDEF MEM_CHECK}
                             DisableMemCheck();
                      {$ENDIF}
	end;


    result:=state;
       end;

function tCMDP.AddAction(ID: integer):CMDPACTION;

        Begin
         //CMDPACTION*
        action := ^CMDPACTION;

         {$IFDEF MEM_CHECK}
	DisableMemCheck();
         {$ENDIF}

	SetLength(action,Length(Actions)-1);  //Actions.push_back(action);

         {$IFDEF MEM_CHECK}
	EnableMemCheck();
         {$ENDIF}


	result := action;

end;

procedure tCMD.Print(fOut :Textfile);
begin
     //SBPL_FPRINTF(fOut, "MDP statespace size=%d\n", (unsigned int)StateArray.size());
	for  i := 0 to Lenght(StateArray) do
begin
		//SBPL_FPRINTF(fOut, "%d: ", StateArray[i]->StateID);
		for j := 0 to StateArray[i]^.Length(Actions) do
		begin
			action := ^CMDPACTION; StateArray[i]^.Actions[j];
			//SBPL_FPRINTF(fOut, "[%d", action->ActionID);

		for outind := 0 to action^.Length(SuccsID) do
			begin
			//	SBPL_FPRINTF(fOut, " %d %d %f", action->SuccsID[outind], action->Costs[outind],
					action^.SuccsProb[outind]);
			end;
			//SBPL_FPRINTF(fOut, "] ");
		end;
		//SBPL_FPRINTF(fOut, "\n");
                   end;
 end;

 function tCMDP.Delete(): boolean;
    action : ^CMDPACTION;
  begin

	if(self.PlannerSpecificData <> nil)
	begin
		//SBPL_ERROR("ERROR deleting state: planner specific data is not deleted\n");
		//throw new SBPL_Exception();
        end;


	//delete predecessors array
	SetLength(PredsID,0);


	//delete actions array
	while((int)Actions > 0)
	begin
		action := Actions[Length(Actions)-1];
		SetLength(PredsID,Length(PredsID)-1);

		action^.Delete();
		 action.Free;
        end;


	 result := true;
  end;
constructor tCMDP.cCMDP();
begin

       end;

     destructor tCMDP.dCMDP;
     begin
       end;

end.

