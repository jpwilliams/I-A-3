/*
	File:	fn_collectGarbage.sqf
	Author:	Rarek [AW]

	Description
		|	Cleans up objects and groups, either globally or within the array
		|	passed.
		|____________________

	Parameters
		|	0	-	Array of objects / groups (Array)
		|			OPTIONAL
		|____________________

	Returns
		|	Nothing
		|____________________

	Examples
		|	[] call AW_fnc_collectGarbage;
		|	_attackers call AW_fnc_collectGarbage;
		|____________________

	To-Do
		|	Need to work out a way to periodically add and remove dead bodies /
		|	objects. Maybe a limited array?
		|
		|	We could add a Killed EH via an Init EH to each unit and then proceed
		|	to add them to a limited array upon death. This way, we can make sure
		|	there's always a fixed amount of dead bodies and it'll never go over
		|	the limit.
		|____________________
*/

_cleanAll = false;
if (count _this < 1) then
{
	_cleanAll = true;
}
else
{
	{
		_type = typeName _x;
		switch (_type) do
		{
			case "OBJECT": { if (!isNull _x && !isPlayer _x) then { deleteVehicle _x; }; };
			case "GROUP":
			{
				_units = units _x;
				{
					if (!isNull _x && !isPlayer _x) then { deleteVehicle _x; };
				} forEach _units;

				deleteGroup _x;
			};
		};
	} forEach _this;
};

if (!_cleanAll) exitWith {};

{
	if (!isNull _x && !isPlayer _x) then { deleteVehicle _x; };
} forEach allDead;

{
	_canDeleteGroup = true;
	{
		if (!isNull _x && alive _x) exitWith { _canDeleteGroup = false; };
	} forEach units _x;

	if (_canDeleteGroup && !isNull _x) then { deleteGroup _x; };
} forEach allGroups;