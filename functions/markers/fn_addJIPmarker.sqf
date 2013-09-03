_marker = _this select 0;
_type = _this select 1;
_state = _this select 2;
_pos = _this select 3;
_text = if ((count _this) > 4) then { _this select 4 } else { "" };

_path = [JIPmarkers, _marker] call BIS_fnc_findNestedElement;
if ((count _path) > 0) then
{
	_element = _path select 0;
	[JIPmarkers, [_element, 1], _type] call BIS_fnc_setNestedElement;
	[JIPmarkers, [_element, 2], _state] call BIS_fnc_setNestedElement;
	[JIPmarkers, [_element, 3], _pos] call BIS_fnc_setNestedElement;
	[JIPmarkers, [_element, 4], _text] call BIS_fnc_setNestedElement;
} else {
	JIPmarkers = JIPmarkers + [[_marker, _type, _state, _pos, _text]];
};

publicVariable "JIPmarkers";