/*
	Author: Karel Moricky, tweaked by Rarek

	Description:
	Selects random position withing trigger area

	Parameter(s):
	_this select 0:
		OBJECT - trigger (automatically sets area param)
		ARRAY - position
		STRING - marker
	_this select 1:
		NUMBER - radius around position set in param 0.
		ARRAY - trigger settings in format of triggerArea command

	Returns:
	ARRAY - [x,y,z]
*/

private ["_tPos","_tPosX","_tPosY","_tArea","_tX","_tY","_tDir","_tShape","_vector"];

_tPos =	[_this,0,[0,0,0],[[],objnull,""],[2,3]] call bis_fnc_param;
_tArea = [_this,1,0,[[],0],4] call bis_fnc_param;

//--- Trigger
if (typename _tPos == typename objnull) then {
	_tArea = triggerarea _tPos;
	_tPos = position _tPos;
};
//--- Marker
if (typename _tPos == typename "") then {
	_tArea = markersize _tPos + [markerdir _tPos,markershape _tPos == "rectangle"];
	_tPos = markerpos _tPos;
};

//--- Position
_tPosX = _tPos select 0;
_tPosY = _tPos select 1;

//--- Area
if (typename _tArea == typename 0) then {_tArea = [_tArea,_tArea,0,false]};
_tX = _tarea select 0; 
_tY = _tarea select 1;
_tDir = _tarea select 2;
_tShape = _tarea select 3;

//--- Random position
_vector = if (_tShape) then {

	//--- Rectangle
	[
		(-_tX + 2 * random _tX),
		(-_tY + 2 * random _tY)
	]
} else {

	//--- Ellipse
	private ["_ranDir"];
	_ranDir = random 360;
	[
		(cos _ranDir * random _tX),
		(sin _ranDir * random _tY)
	]
};

//--- Rotate according to area
_vector = [_vector,-_tDir] call bis_fnc_rotateVector2D;

//--- Convert to world coordinates
[
	_tPosX + (_vector select 0),
	_tPosY + (_vector select 1),
	0
]
