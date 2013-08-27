_obj	=	_this select 0; if (isNull _obj) exitWith {};
_params	=	_this select 1; if ((typeName _params) != "ARRAY") exitWith {};
_local	=	if ((count _this) > 2) then { _this select 2 } else { false };

_id = 0;
if (!(isServer && _local)) then { _id = _obj addAction _params; };
_ret = [_id, _obj];

//Add to JIP array
if (isServer && !_local) then
{
	[[_obj, _params, true], "AW_fnc_createAction", true] call BIS_fnc_MP;

	JIPactions = JIPactions + [[_ret, _params]];
	publicVariable "JIPactions";
};

_ret