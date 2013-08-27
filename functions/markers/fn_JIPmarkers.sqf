/*
	File:	fn_JIPmarkers.sqf
	Author:	Rarek [AW]

	Description
		|	Used to allow JIPPs to create local markers
		|	in place of currently-existing global markers.
		|____________________
*/

private["_name", "_state", "_pos", "_text"];

localMarkers = JIPmarkers;

{
	_name	=	_x select 0;
	_state	=	_x select 1;
	_pos	=	_x select 2;
	_text	=	_x select 3;

	_marker = createMarkerLocal [_name, _pos];
	[_state, _name, _pos, _text] call AW_fnc_createMarker;
} forEach localMarkers;