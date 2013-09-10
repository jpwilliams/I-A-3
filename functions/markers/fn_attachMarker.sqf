private ["_this", "_obj", "_type", "_state", "_number", "_name", "_markers"];

_state = "init";
_obj = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_type = [_this,1,"",[[],""],[2]] call BIS_fnc_param;
if (typeName _type == "ARRAY") then { _state = _type select 1; _type = _type select 0; };
_condition = [_this,2,{alive _obj},[{}]] call BIS_fnc_param;

_number = 0;
_name = "";
while { true } do
{
	_number = _number + 1;
	_name = format["%1_%2_%3", _type, _state, _number];
	if (!(_name in allMapMarkers)) exitWith {};
};

_markers = [_state, _type, _name, (getPos _obj)] call AW_fnc_createJIPstateMarker;

[_markers, _obj, _condition] spawn
{
	private ["_icon", "_obj", "_x", "_markers", "_condition"];

	_markers = _this select 0;
	_obj = _this select 1;
	_condition = _this select 2;

	while _condition do
	{
		sleep 2;
		{
			_x setMarkerPos (getPos _obj);
		} forEach _markers;
	};

	[_markers] call AW_fnc_deleteMarker;
};

_markers