private["_title", "_subfolder", "_pos", "_taskDescription", "_fsmHandle"];
_subfolder = _this;

/*
	Example config file for Side Mission

	All values are required
*/

_title		=	"Destroy Chopper";
_pos		=	["land", true, 5] call AW_fnc_findSpace;

/*
	And now you're not allowed to edit.
	No editing! I said GO! SHOO!
*/

_fsmHandle = _pos execFSM format["missions\side\%1\mission.fsm", _subfolder];
_ret = [_title, _pos, _fsmHandle]; _ret