//Notify developers that messages must be limited to 30 characters.

private["_type", "_message", "_detail", "_details", "_target"];

_type = "";
_message = "";
_detail = "";
_details = [];
_hint = [];
_target = true;

{
	switch (_x select 0) do
	{
		case "type":	{ _type = _x select 1; };
		case "message":	{ _message = _x select 1; };
		case "detail":	{ _detail = _x select 1; };
		case "target":	{ _target = _x select 1; };
		case "hint": 	{ _hint = _x select 1; };
	}
} forEach _this;

if (_type != "") then
{
	if (_detail == "") then
	{
		_details = [_message];
	} else {
		_details = [_message, _detail];
	};

	[[_type, _details], "bis_fnc_showNotification", _target, false] call BIS_fnc_MP;
	if ((count _hint) > 0) then { [[_hint, 15], "BIS_fnc_advHint", _target, false] call BIS_fnc_MP; };
} else {
	diag_log "::::::::: AW_DEBUG ::::::::: No type given for AW_fnc_showNotification";
};