private["_title", "_subfolder", "_pos", "_taskDescription", "_fsmHandle"];

/*
	Example config file for Side Mission

	All values are required
*/

_title		=	"Destroy Mortar Team";
_subfolder	=	"mortarTeam"; //name of the SM sub-folder
_pos		=	["land", true, 5] call AW_fnc_findSpace;
_taskDescription = "Your objective is simple, fellas. Find and destroy the enemy chopper. OPFOR forces will gain a pretty hefty advantage if they get that thing up in the air, so let's blow the bugger before they even get the chance!";

/*
	And now you're not allowed to edit.
	No editing! I said GO! SHOO!
*/

_fsmHandle = [_title, _subfolder, _pos, _taskDescription] execFSM "missions\priority\loader.fsm"; _fsmHandle