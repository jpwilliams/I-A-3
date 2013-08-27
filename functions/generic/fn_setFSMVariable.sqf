//AW_fnc_setFSMVariable;

_id = _this select 0;
_var = _this select 1;
_value = _this select 2;

if (isServer) then
{
	_id setFSMVariable [_var, _value];
} else {
	[_this, "AW_fnc_setFSMVariable", false, false] call BIS_fnc_MP;
}