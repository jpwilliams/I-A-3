_task = _this;
_children = [_task] call BIS_fnc_taskChildren;

_complete = true;

{
	if (!([_x] call BIS_fnc_taskCompleted)) exitWith
	{
		_complete = false;
	};
} forEach _children;

_complete