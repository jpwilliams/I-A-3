private ["_this", "_base", "_fsmHandle", "_ret", "_result"];

_type = [_this,0,"",[""]] call BIS_fnc_param;
_base = [_this,1,[],["",[],objNull],[2,3]] call BIS_fnc_param;
if (typeName _base == "OBJECT") then { _base = getPos _base; };

if (isServer) then
{
	_fsmHandle = [_type, _base] call AW_fnc_baseVehSpawnMachine;
	while { true } do
	{
		if (completedFSM _fsmHandle) exitWith {};
	};

	_ret = result;

	_ret
} else {
	[[_type, _base], "AW_fnc_baseVehSpawn", false, false] call BIS_fnc_MP;
};