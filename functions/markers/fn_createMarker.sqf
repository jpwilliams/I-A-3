private["_this", "_type", "_name", "_pos", "_text", "_marker", "_path", "_element"];

_state	=	"init";
_type	=	_this select 0;
_name	=	_this select 1;
_pos	=	_this select 2;
_text	=	if ((count _this) > 3) then { _this select 3 } else { "" };
_local	=	if ((count _this) > 4) then { _this select 4 } else { false };
_markers = [];

if ((typeName _type) == "ARRAY") then
{
	_state = _type select 1;
	_type = _type select 0;
};

_root = missionConfigFile >> "CfgMarkers" >> format["%1_%2", _type, _state];
{
	_marker = format["%1_%2", _name, _x];

	if (markerColor _marker == "") then
	{
		if (_local) then
		{
			_marker = createMarkerLocal [_marker, _pos];
		} else {
			_marker = createMarker [_marker, _pos];
		};
	} else {
		_marker setMarkerPos _pos;
	};

	_settings = _root >> _x;
	_lastIndex = ((count _settings) - 1);

	for "_i" from 0 to _lastIndex do
	{
		_s = _settings select _i;
		_s_name = configName _s;
		switch (_s_name) do
		{
			case "shape":	{ _marker setMarkerShape (getText _s); };
			case "type":	{ _marker setMarkerType (getText _s); };
			case "brush":	{ _marker setMarkerBrush (getText _s); };
			case "color":	{ _marker setMarkerColor (getText _s); };
			case "size":	{ _marker setMarkerSize (getArray _s); };
			case "text":	{ _marker setMarkerText	format["%1 %2", (getText _s), _text]; };
		};
	};

	_markers = _markers + [_marker];
} forEach ["marker", "icon"];

if (isServer) then
{
	//Add to JIP array
	{
		_path = [JIPmarkers, _x] call BIS_fnc_findNestedElement;
		if ((count _path) > 0) then
		{
			_element = _path select 0;
			[JIPmarkers, [_element, 1], _type] call BIS_fnc_setNestedElement;
			[JIPmarkers, [_element, 2], _state] call BIS_fnc_setNestedElement;
			[JIPmarkers, [_element, 3], _pos] call BIS_fnc_setNestedElement;
			[JIPmarkers, [_element, 4], _text] call BIS_fnc_setNestedElement;
		} else {
			JIPmarkers = JIPmarkers + [[_x, _type, _state, _pos, _text]];
		};
	} forEach _markers;	
		
	publicVariable "JIPmarkers";
};

//returns marker names in array (e.g. ["base_connor_marker", "base_connor_icon"])
_markers
