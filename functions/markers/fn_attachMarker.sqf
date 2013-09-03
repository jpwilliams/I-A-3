//AW_fnc_attachMarker;
//[_myUnit, "misc", "ammo_truck"] call AW_fnc_attachMarker;

private ["_this", "_obj", "_type", "_state", "_number", "_name", "_markers"];

_obj = _this select 0;
_type = _this select 1; _state = "init";
if (typeName _type == "ARRAY") then { _type = (_this select 1) select 0; _state = (_this select 1) select 1; };
_condition = if ((count _this) > 2) then { _this select 2 } else { { alive _obj } };

/*
	1. Create icon marker
	2. Add to JIP array
	3. Pass back name
*/

_number = 0;
_name = "";
while { true } do
{
	_number = _number + 1;
	_name = format["%1_%2_%3", _type, _state, _number];
	if (!(_name in allMapMarkers)) exitWith {};
};

_markers = [_state, _type, _name, (getPos _obj)] call AW_fnc_createJIPstateMarker;

[_markers, _obj] spawn
{
	private ["_icon", "_obj", "_x", "_markers"];

	_markers = _this select 0;
	_obj = _this select 1;

	while _condition do
	{
		sleep 2;
		{
			_x setMarkerPos (getPos _obj);
		} forEach _markers;
	};
};

_markers