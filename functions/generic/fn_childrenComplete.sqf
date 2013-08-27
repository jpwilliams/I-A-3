/*
	File:	fn_childrenComplete.sqf
	Author:	Rarek [AW]

	Description
		|	A simple way to check if the sub-tasks of the given task
		|	are all complete.
		|____________________

	Parameters
		|	0	-	Task Name (String)
		|			REQUIRED
		|____________________

	Returns
		|	TRUE for all complete, otherwise FALSE (Bool)
		|____________________

	Examples
		|	_childrenComplete = "myTask" call AW_fnc_childrenComplete;
		|____________________
*/

_task = _this select 0;
_children = [_task] call BIS_fnc_taskChildren;

_complete = true;

{
	if (!([_x] call BIS_fnc_taskCompleted)) exitWith
	{
		_complete = false;
	};
} forEach _children;

_complete