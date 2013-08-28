/*
	File:	fn_deleteMarker.sqf
	Author:	Rarek [AW]

	Description
		|	Delete markers, concious of JIP compatibility
		|____________________

	Parameters
		|	0 - STRING: Marker name
		|	1 - BOOL: Handling local markers? //FALSE
		|____________________
*/

private["_markers", "_local", "_path", "_x"];

_markers = _this select 0;
_local = if ((count _this) > 1) then { (_this select 1) } else { false };

if (typeName _temp != "ARRAY") then
{
	_markers = [_markers];
};

if (!_local) then
{
	{
		_path = [JIPmarkers, _x] call BIS_fnc_findNestedElement;
		if ((count _path) > 0) then
		{
			JIPmarkers = [JIPmarkers, (_path select 0)] call BIS_fnc_removeIndex;
			publicVariable "JIPmarkers";
		};

		deleteMarker _x;
	} forEach _markers;
	[[_markers, true], "AW_fnc_deleteMarker", true, false] call BIS_fnc_MP;
} else {
	if ((count localMarkers) > 0) then
	{
		{
			_path = [localMarkers, _x] call BIS_fnc_findNestedElement;
			if ((count _path) > 0) then
			{
				localMarkers = [localMarkers, (_path select 0)] call BIS_fnc_removeIndex;
				deleteMarkerLocal _x;
			};
		} forEach _markers;
	};
};