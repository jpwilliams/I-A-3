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
