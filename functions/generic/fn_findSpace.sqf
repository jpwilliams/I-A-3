/*
	File:	fn_findSpace.sqf
	Author:	Rarek [AW]

	Description
		|	A simple way to find empty space using a series of parameters.
		|	Designed for Side Mission / Priority Target creators who wish
		|	to easily find space without having to faff around with findSafePos,
		|	randomPos and isFlatEmpty.
		|
		|	As a way to force the I&A 3 design, developers using this function
		|	cannot search for a position within a specific area and must instead
		|	search across the entirety of the game map.
		|____________________

	Parameters
		|	0	-	Area (String)
		|			REQUIRED
		|				// treat this as "must be in/on X"
		|				-	"water" // ignores "must be flat" bool
		|				-	"shore"
		|				-	"land"
		|				-	"civilisation"
		|				-	"anywhere"
		|				-	"main"
		|	1	-	Must be flat? (Bool|Optional)
		|			Default FALSE
		|				// essential for artillery pieces etc
		|	2	-	Empty space needed radius (Object OR Integer OR classname|Optional)
		|			Default 1
		|				// If object, gets size and finds relevant empty space
		|				// Otherwise, it'll just find an empty space with the
		|				// radius given.
		|				// Useful for spawning large buildings when size is unknown
		|____________________

	Returns
		|	Single position in format [x,y,z] (Array)
		|____________________

	Examples
		|	_pos = ["inland", TRUE, "O_Mortar_className_F"] call AW_fnc_findSpace;
		|	_pos = ["water"] call AW_fnc_findSpace;
		|	_pos = ["anywhere", FALSE, 50] call AW_fnc_findSpace;
		|____________________
*/

private ["_this", "_area", "_gradient", "_radius"];

_area = [_this,0,"land",[""]] call BIS_fnc_param;

_gradient = [_this,1,2000,[true]] call BIS_fnc_param;
if (typeName _gradient == "BOOL" && _gradient) then { _gradient = 0.3; };

_radius = [_this,2,1,[objNull,[]]] call BIS_fnc_param;
if (typeName _radius == "OBJECT") then { _radius = getPos _radius; };

_pos = [];
_validPos = false;

while {!_validPos} do
{
	_validPos = true;

	switch (_area) do
	{
		case "water": { _pos = [[], 0, -1, _radius, 2, 2000, 0] call BIS_fnc_findSafePos; };
		case "shore": { _pos = [[], 0, -1, _radius, 1, _gradient, 1] call BIS_fnc_findSafePos; };
		case "land": { _pos = [[], 0, -1, _radius, 0, _gradient, 0] call BIS_fnc_findSafePos; };
		case "civilisation": { /* to be created :D */ };
		case "anywhere": { _pos = [[], 0, -1, _radius, 1, _gradient, 0] call BIS_fnc_findSafePos; };
		case "main":
		{
			_mainPos = [];
			{ if (["main_", _x] call BIS_fnc_inString) exitWith { _mainPos = markerPos _x; }; } forEach allMapMarkers;
			_pos = [_mainPos, 0, 500, _radius, 0, _gradient, 0] call BIS_fnc_findSafePos;
		};
		case "poi":	{ _pos = markerPos (pointsOfInterest call BIS_fnc_selectRandom); };
		default {};
	};

	{
		if ((_x distance _pos) < 1000) exitWith { _validPos = false; };
	} forEach playableUnits;
};

_pos