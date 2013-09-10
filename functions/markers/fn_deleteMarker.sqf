private["_markers", "_local", "_path", "_x"];

_markers = [_this,0,[],["",[]]] call BIS_fnc_param;
_local = [_this,1,false,[true]] call BIS_fnc_param;

if (typeName _markers != "ARRAY") then
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