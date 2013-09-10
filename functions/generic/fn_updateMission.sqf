private ["_this", "_type", "_title", "_code", "_notif", "_description", "_hint", "_marker", "_markers", "_pos", "_x", "_cur", "_new", "_marker_marker", "_marker_icon"];

_type = _this select 0;
_title = switch (_type) do
{
	case "tactical": { "Tactical" };
	case "ghost": { "Ghost" };
	case "sub": { "Sub-Objective" };
	case "priority": { "Priority" };
};
_code = _this select 1;

_notif = "";
_description = "";
_hint = [];
_marker = "";
_markers = [];
_pos = [];

{
	switch (_x select 0) do
	{
		case "notification": { _notif = _x select 1; };
		case "description": { _description = _x select 1; };
		case "hint": { _hint = _x select 1; };
		case "marker": { _marker = _x select 1; };
		case "pos": { _pos = _x select 1; };
	};
} forEach (_this select 2);

if (_notif != "") then
{
	[["type", format["%1_updated", _type]], ["message", format["UPDATE: %1", _notif]]] call AW_fnc_showNotification;
};

if (_description != "") then
{
	_cur = _code call BIS_fnc_taskDescription;
	_new = format["%1<br/><br/>UPDATE: %2", (_cur select 0), _description];

	[_code, [_new, (_cur select 1), (_cur select 2)]] call BIS_fnc_taskSetDescription;
};

if ((count _hint) > 0) then
{
	[[_hint, 15], "BIS_fnc_advHint", true, false] call BIS_fnc_MP;
};

if (_marker != "" && (count _pos) > 0) then
{
	_marker_marker = [format["%1MarkerUpdate", _type], format["%1_update", _code], _pos] call AW_fnc_createJIPstateMarker;
	_marker_icon = [format["%1MarkerUpdateIcon", _type], format["%1_update_icon", _code], _pos, format["%1 Update: %2", _title, _marker]] call AW_fnc_createJIPstateMarker;

	_markers = [_marker_marker, _marker_icon];
} else {
	_markers = ["", ""];
};

_markers