private ["_spawnedUnits", "_side", "_soldiers", "_vehicles", "_toSpawn", "_type", "_pos", "_randomUnit", "_i", "_c", "_group", "_amount", "_loc", "_radius"];

// _units = [EAST, 30] call AW_fnc_spawnEnemy;

_spawnedUnits = [];
_side = _this select 0;
_amount = _this select 1;
_loc = _this select 2;
_radius = if ((count _this) > 3) then { _this select 3 } else { "" };

_soldiers =
[
	"O_Soldier_A_F",
	"O_Soldier_AA_F",
	"O_Soldier_AAA_F",
	"O_Soldier_AAR_F",
	"O_Soldier_AAT_F",
	"O_Soldier_AR_F",
	"O_Soldier_AT_F",
	"O_Soldier_F",
	"O_Soldier_GL_F",
	"O_Soldier_LAT_F",
	"O_Soldier_lite_F",
	"O_Soldier_M_F",
	"O_Soldier_repair_F",
	"O_Soldier_SL_F",
	"O_Soldier_TL_F",
	"O_spotter_F",
	"O_sniper_F",
	"O_medic_F",
	"O_engineer_F"
];

_vehicles =
[
	"O_MRAP_02_gmg_F",
	"O_MRAP_02_hmg_F",
	"O_APC_Wheeled_02_rcws_F"
];

_boats =
[

];

for [{_i = 0}, {_i < _amount}, {_i = _i + 1}] do
{
	_toSpawn = [];
	_type = if ((random 1) > 0.2) then { "infantry" } else { "vehicle" };

	_lName = typeName _loc;
	_ret = [];

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
			_rand = round(4 + random(6));

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
	};
};

_spawnedUnits