private["_name", "_type", "_state", "_pos", "_text"];

localMarkers = JIPmarkers;

{
	_name	=	_x select 0;
	_type	=	_x select 1;
	_state	=	_x select 2;
	_pos	=	_x select 3;
	_text	=	_x select 4;

	[[_type, _state], _name, _pos, _text, true] call AW_fnc_createJIPstateMarker;
} forEach localMarkers;
