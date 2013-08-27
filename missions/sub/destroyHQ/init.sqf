private["_title", "_subfolder", "_pos", "_taskDescription", "_fsmHandle"];

/*
	Example config file for Sub Objective

	All values are required
*/

_subTitle		=	"Destroy Enemy HQ";
_subfolder	=	"destroyHQ"; //name of the SM sub-folder
_subPos		=	["main", true, 3] call AW_fnc_findSpace;

/*
	And now you're not allowed to edit.
	No editing! I said GO! SHOO!
*/

_fsmHandle = [_subTitle, _subfolder, _pos] execFSM "missions\sub\loader.fsm"; _fsmHandle