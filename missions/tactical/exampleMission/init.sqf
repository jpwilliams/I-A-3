private["_title", "_subfolder", "_pos", "_taskDescription", "_fsmHandle"];

/*
	DO NOT EDIT ABOVE THIS COMMENT

	Example init for Side Missions.
*/

_title		=	"Example Mission";
_subfolder	=	"exampleMission"; //name of the SM sub-folder
_pos		=	["land"] call AW_fnc_findSpace;
_taskDescription = "This is the description that will appear in the Side Mission task list. When writing, imagine it's a brief... briefing sent from HQ. Be descriptive but efficient.";

/*
	No editing below here.
	I said no editing! I said GO! SHOO!
*/

_fsmHandle = [_title, _subfolder, _pos, _taskDescription] execFSM "missions\side\loader.fsm"; _fsmHandle