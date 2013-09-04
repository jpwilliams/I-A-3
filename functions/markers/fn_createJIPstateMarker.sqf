private["_this", "_type", "_name", "_pos", "_text", "_marker", "_path", "_element"];

_state	=	"init";
_type = [_this,0,"",["", []],[2]] call BIS_fnc_param;
_name = [_this,1,"",[""]] call BIS_fnc_param;
_pos = [_this,2,[0,0,0],[[]],[2,3]] call BIS_fnc_param;
_text = [_this,3,"",[""]] call BIS_fnc_param;
_local = [_this,4,false,[true]] call BIS_fnc_param;
_markers = [];

if ((typeName _type) == "ARRAY") then
{
	_state = _type select 1;
	_type = _type select 0;
};

_root = missionConfigFile >> "CfgMarkers" >> _type >> _state;
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

	if (_x == "marker" && markerColor _name != "") then
	{
		_marker setMarkerSize (markerSize _name);
		_marker setMarkerDir (markerDir _name);
	};

	if (_x == "icon" && _text != "") then { _marker setMarkerText _text; };

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
			case "text":
			{
				_chars = if (isText (_s)) then
				{
					format["%1 %2", (getText _s), _text]
				} else {
					_temp = getArray _s;
					format["%1 %2 %3", (_temp select 0), _text, (_temp select 1)]
				};

				_marker setMarkerText _chars;
			};
		};
	};

	_markers = _markers + [_marker];
} forEach ["marker", "icon"];

if (isServer) then
{
	{
		[_x, _type, _state, _pos, _text] call AW_fnc_addJIPmarker;
	} forEach _markers;
};

//returns marker names in array (e.g. ["base_connor_marker", "base_connor_icon"])
_markers
