private ["_this", "_id", "_var", "_value"];

_id = [_this,0] call BIS_fnc_param;
_var = [_this,1,"",[""]] call BIS_fnc_param;
_value = [_this,2] call BIS_fnc_param;

if (isServer) then
{
	_id setFSMVariable [_var, _value];
} else {
	[_this, "AW_fnc_setFSMVariable", false, false] call BIS_fnc_MP;
}