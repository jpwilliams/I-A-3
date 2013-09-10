_marker = [_this,0,"",[""]] call BIS_fnc_param;
_type = [_this,1,"",[""]] call BIS_fnc_param;
_state = [_this,2,"init",[""]] call BIS_fnc_param;
_pos = [_this,3,[0,0,0],[[]],[2,3]] call BIS_fnc_param;
_text = [_this,4,"",[""]] call BIS_fnc_param;

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