private["_title", "_subfolder", "_pos", "_taskDescription", "_fsmHandle"];
_subfolder = _this select 0;
_code = _this select 1;

/*
	Example config file for Side Mission

	All values are required
*/

_title		=	"Get Documents";
_pos		=	["land", true, 15] call AW_fnc_findSpace;

/*
	And now you're not allowed to edit.
	No editing! I said GO! SHOO!
*/

_fsmHandle = [_pos, _code] execFSM format["missions\tactical\%1\mission.fsm", _subfolder];
_ret = [_title, _pos, _fsmHandle]; _ret