/*
	File:	fn_createMarker.sqf
	Author:	Rarek [AW]

	Description
		|	Creates / handles JIP-compatible marker creation and
		|	edits throughout I&A 3.
		|____________________

	Parameters
		|	0 - String: State to set marker to
		|	1 - String: Name of marker
		|	2 - Array: Position
		|	3 - String: Marker text
		|____________________

	Returns
		|	Marker name (String)
		|____________________
*/

private["_this", "_type", "_name", "_pos", "_text", "_marker", "_path", "_element"];

_type	=	_this select 0;
_name	=	_this select 1;
_pos	=	_this select 2;
_text	=	if ((count _this) > 3) then { _this select 3 } else { "" };

if (markerColor _name == "") then
{
	_marker = createMarker [_name, _pos];
}
else
{
	_marker = _name;
	_marker setMarkerPos _pos;
};

switch (_type) do
{
	case "mainMarker":
	{
		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerBrush "FDiagonal";
		_marker setMarkerColor "ColorRed";
		_marker setMarkerSize [600, 600];
	};

	case "mainIcon":
	{
		_marker setMarkerShape "ICON";
		_marker setMarkerType "o_unknown";
		_marker setMarkerColor "ColorOPFOR";
		_marker setMarkerText _text;
	};

	case "tacticalMarker":
	{
		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerBrush "Border";
		_marker setMarkerColor "ColorOPFOR";
		_marker setMarkerSize [300, 300];
	};

	case "tacticalMarkerUpdate":
	{
		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerBrush "BDiagonal";
		_marker setMarkerColor "ColorOPFOR";
		_marker setMarkerSize [50, 50];
		_marker setMarkerText _text;
	};

	case "tacticalMarkerUpdateIcon":
	{
		_marker setMarkerShape "ICON";
		_marker setMarkerType "selector_selectedEnemy";
		_marker setMarkerColor "ColorOPFOR";
		_marker setMarkerText _text;
	};

	case "tacticalIcon":
	{
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_dot";
		_marker setMarkerColor "ColorOPFOR";
		_marker setMarkerText _text;
	};

	case "priorityMarker":
	{
		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerBrush "Border";
		_marker setMarkerColor "ColorOPFOR";
		_marker setMarkerSize [300, 300];
	};

	case "priorityIcon":
	{
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_dot";
		_marker setMarkerColor "ColorOPFOR";
		_marker setMarkerText _text;
	};
	case "baseMarker_enemy": { _marker setMarkerColor "ColorOPFOR"; };
	case "baseMarker_contested": { _marker setMarkerColor "ColorUnknown"; };
	case "baseMarker_friendly": { _marker setMarkerColor "ColorBLUFOR"; };

	case "baseIcon_enemy":
	{
		_marker setMarkerShape "ICON";
		_marker setMarkerType "o_unknown";
		_marker setMarkerColor "ColorOPFOR";
		_marker setMarkerText _text;
	};

	case "baseIcon_contested":
	{
		_marker setMarkerShape "ICON";
		_marker setMarkerType "n_unknown";
		_marker setMarkerColor "ColorOrange";
		_marker setMarkerText format["(Under Attack) %1", _text];
	};

	case "baseIcon_friendly":
	{
		_marker setMarkerShape "ICON";
		_marker setmarkerType "b_unknown";
		_marker setMarkerColor "ColorBLUFOR";
		_marker setMarkerText _text;
	};
};

if (isServer) then
{
	//Add to JIP array
	_path = [JIPmarkers, _marker] call BIS_fnc_findNestedElement;
	if ((count _path) > 0) then
	{
		_element = _path select 0;
		[JIPmarkers, [_element, 1], _type] call BIS_fnc_setNestedElement;
		[JIPmarkers, [_element, 2], _pos] call BIS_fnc_setNestedElement;
		[JIPmarkers, [_element, 3], _text] call BIS_fnc_setNestedElement;
	} else {
		JIPmarkers = JIPmarkers + [[_marker, _type, _pos, _text]];
	};
	publicVariable "JIPmarkers";
};

//returns marker name
_marker