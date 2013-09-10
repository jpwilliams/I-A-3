private["_pos", "_radius", "_double", "_fuzzyPos"];

_pos = [_this,0,[0,0,0],[[], objNull],[2,3]] call BIS_fnc_param;
if (typeName _pos == "OBJECT") then { _pos = getPos _pos; };
_radius = [_this,1,100,[0]] call BIS_fnc_param;
_double = (_radius * 2);

_fuzzyPos =
[
	((_pos select 0) - _radius) + (random _double),
	((_pos select 1) - _radius) + (random _double),
	0
];

_fuzzyPos
