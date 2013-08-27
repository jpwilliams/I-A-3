_obj = _this;
AW_dead = AW_dead + [_obj];

if ((count AW_dead) > PARAMS_bodyLimit) then
{
	while { (count AW_dead) > PARAMS_bodyLimit } do
	{
		_deadThing = AW_dead select 0;
		_group = group _deadThing;
		deleteVehicle _deadThing;

		_canDeleteGroup = true;
		{
			if (!isNull _x && alive _x) exitWith { _canDeleteGroup = false; };
		} forEach (units _group);
		if (_canDeleteGroup) then { deleteGroup _group; };

		//Is this necessary? Does the object get automatically deleted from the array?
		AW_dead = [AW_dead, 0] call BIS_fnc_removeIndex;
	};
};