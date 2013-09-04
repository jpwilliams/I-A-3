_obj	=	[_this,0,objNull,[objNull]] call BIS_fnc_param;
_params	=	[_this,1,[],[[]]] call BIS_fnc_param;
_local	=	[_this,2,false,[true]] call BIS_fnc_param;

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