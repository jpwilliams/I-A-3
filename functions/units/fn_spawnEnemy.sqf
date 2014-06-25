private ["_spawnedUnits", "_side", "_soldiers", "_vehicles", "_toSpawn", "_type", "_pos", "_randomUnit", "_i", "_c", "_group", "_amount", "_loc", "_radius"];

// Set defaults
_side = [_this,0,EAST,[EAST]] call BIS_fnc_param;
_amount = [_this,1,5,[0]] call BIS_fnc_param;
_loc = [_this,2,[0,0,0],[[],""],[2,3]] call BIS_fnc_param;
_radius = [_this,3,100,[[],0],[2]] call BIS_fnc_param;

// Grab enemy units
_spawnedUnits = [];
_soldiers = getArray (missionConfigFile >> "enemy" >> "infantry");
_vehicles = getArray (missionConfigFile >> "enemy" >> "vehicles");
_static = getArray (missionConfigFile >> "enemy" >> "static");
_boats = getArray (missionConfigFile >> "enemy" >> "boats");
_air = getArray (missionConfigFile >> "enemy" >> "air");
_unitTypes = ["infantry", "vehicle", "air", "static"];
_chances = [0.75, 0.15, 0.03, 0.07];

// Creation loop
for [{_i = 0}, {_i < _amount}, {_i = _i + 1}] do
{
	_toSpawn = [];
	_ret = [];
	_lName = typeName _loc;
	_type = [_unitTypes, _chances] call BIS_fnc_selectRandomWeighted;

	_pos = switch (_lName) do
	{
		case "ARRAY":
		{
			_rName = typeName _radius;
			_ret = switch (_rName) do
			{
				case "ARRAY":
				{
					[_loc, (_radius select 0), (_radius select 1), 1, 0, 2000, 0] call BIS_fnc_findSafePos
				};

				case "SCALAR":
				{
					[[[_loc, _radius]], ["water", "out"]] call BIS_fnc_randomPos
				};
			};

			_ret
		};

		case "STRING":
		{
			_tempPos = [_loc] call AW_fnc_randomPosTrigger;
			_ret = [_tempPos, 0, 50, 2, 0, 2000, 0] call BIS_fnc_findSafePos;

			_ret
		};
	};

	switch (_type) do
	{
		case "infantry":
		{
			_rand = round(6 + random(4));

			for [{_c = 0}, {_c < _rand}, {_c = _c + 1}] do
			{
				_randomUnit = _soldiers call BIS_fnc_selectRandom;
				_toSpawn = _toSpawn + [_randomUnit];
			};

			_group = [_pos, _side, _toSpawn] call BIS_fnc_spawnGroup;
			{
				_x addEventHandler ["killed", { (_this select 0) call AW_fnc_addDead; }];
			} foreach (units _group);

			_spawnedUnits = _spawnedUnits + [_group];
		};

		case "vehicle":
		{
			_randomUnit = _vehicles call BIS_fnc_selectRandom;
			_group = [_pos, random 360, _randomUnit, _side] call BIS_fnc_spawnVehicle;
			{
				{
					_x addEventHandler ["killed", { (_this select 0) call AW_fnc_addDead; }];
				} forEach _x;
			} forEach [[(_group select 0)], (_group select 1)];

			_spawnedUnits = _spawnedUnits + [_group select 2];
			_spawnedUnits = _spawnedUnits + [_group select 0];
		};

		case "air": // Needs splitting into "plane" and "helicopter"
		{
			_randomUnit = _air call BIS_fnc_selectRandom;
			_group = [_pos, random 360, _randomUnit, _side] call BIS_fnc_spawnVehicle;
			{
				{
					_x addEventHandler ["killed", { (_this select 0) call AW_fnc_addDead; }];
				} foreach _x;
			} foreach [[(_group select 0)], (_group select 1)];

			_spawnedUnits = _spawnedUnits + [_group select 2];
			_spawnedUnits = _spawnedUnits + [_group select 0];
		};

		case "static":
		{
			_randomUnit = _static call BIS_fnc_selectRandom;
			_group = [_pos, random 360, _randomUnit, _side] call BIS_fnc_spawnVehicle;
			{
				{
					_x addEventHandler ["killed", { (_this select 0) call AW_fnc_addDead; }];
				} foreach _x;
			} foreach [[(_group select 0)], (_group select 1)];

			_spawnedUnits = _spawnedUnits + [_group select 2];
			_spawnedUnits = _spawnedUnits + [_group select 0];
		};
	};
};

_spawnedUnits