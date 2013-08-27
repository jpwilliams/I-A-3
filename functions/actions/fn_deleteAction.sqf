_type = (typeName (_this select 0));
_id = 0;
_obj = objNull;
_local = false;

switch (_type) do
{
	case "SCALAR":
	{
		_id 	=	_this select 0;
		_obj 	=	_this select 1;
		_local	=	if ((count _this) > 2) then { _this select 2 } else { false };
	};

	case "ARRAY":
	{
		_id 	=	(_this select 0) select 2;
		_obj 	=	(_this select 0) select 0;
		_local	=	if ((count _this) > 1) then { _this select 1 } else { false };
	};
};

if (isServer) then { _local = false; };
if (!(isServer && _local)) then { _obj removeAction _id; };

if (!_local) then
{
	[[_id, _obj, true], "AW_fnc_deleteAction", true] call BIS_fnc_MP;

	_index = 0;

	{
		_element	= _x select 0;
		_idFound	= _element select 0;
		_objFound	= _element select 1;

		if (_obj == _objFound && _id == _idFound) exitWith
		{
			JIPactions = [JIPactions, _index] call BIS_fnc_removeIndex;
		};

		_index = _index + 1;
	} forEach JIPactions;

	publicVariable "JIPactions";
};