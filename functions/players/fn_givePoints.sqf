/*
	File:	fn_givePoints.sqf
	Author:	Rarek [AW]

	Description
		|	Gives score to the specified player, showing a
		|	notification if a reason is given.
		|____________________

	Parameters
		|	0 - OBJECT: Unit that will receive the score
		|	1 - INTEGER: Score to give
		|	2 - STRING: Reason to show in notification
		|____________________
*/

_unit		=	_this select 0;
_score		=	_this select 1;
if ((count _this) > 2) then { _reason = _this select 2; };

//Give points
_unit addScore _score;

//Show notification?
if (!isNil _reason) then
{
	_params =
	[
		["type", "ScoreBonus"],
		["message", _reason],
		["detail", _score]
	];

	[_params, "AW_fnc_showNotification", _unit] spawn BIS_fnc_MP;
};