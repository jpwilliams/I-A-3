//_reward = ["HEMTT", _nearestBase] call AW_fnc_rewardSpawn; 	// Spawn HEMTT at specified base
//_reward = ["HEMTT", [255,234,10]] call AW_fnc_rewardSpawn; 	// Spawn HEMTT at nearest base to _pos
//_reward = ["HEMTT"] call AW_fnc_rewardSpawn;					// Spawn HEMTT at random base
//_reward = ["land"] call AW_fnc_rewardSpawn;					// Spawn land vehicle at random base
//_reward = ["air"] call AW_fnc_rewardSpawn;					// Spawn air vehicle at random base
//_reward = [] call AW_fnc_rewardSpawn;							// Spawn a random reward at a random base

/* Need to grab types from CfgFile (land, air, sea) here to randomly choose from later */
/* This also needs re-doing; don't do "case 0, 1, 2" lmfao */
_types = [];

_count = count _this;
switch (_count) do
{
	case 0:
	{
		//Spawn a random reward at a random base
		_spawnMarker = ""; _goodSpot = false;
		while { !_goodSpot } do
		{
			_spawnMarker = baseSpawns call BIS_fnc_selectRandom;
			//Check if there are vehicles/units within 5m (that could prevent the spawn of the veh)
			//If not...
			_goodSpot = true;
		};

		_type = "";
		{
			if ([format["_%1_", _x], _spawnMarker] call BIS_fnc_inString) exitWith
			{
				_type = _x;
			};
		} forEach _types;

		if (_type == "") exitWith { /* Error! Couldn't find type in marker! */ };

		_vehicles = getArray (missionConfigFile >> "AW_rewards" >> _type);
		_veh = _vehicles call BIS_fnc_selectRandom;

		[_veh, (markerPos _spawnMarker), (markerDir _spawnMarker)] call AW_fnc_createVehicle;
		["vehicle_reward", (configFile >> "CfgVehicles" >> _veh >> "displayName")] call AW_fnc_showNotification;
		//Should we attach a marker?
	};

	case 1:
	{
		_type = _this select 0;
		if (_type in _types) then
		{
			//Generic vehicle type
			_availableMarkers = [];
			{
				if ([format["_%1_", _type], _x] call BIS_fnc_inString) then
				{
					_availableMarkers = _availableMarkers + [_x];
				};
			} forEach baseSpawns;

			_spawnMarker = ""; _goodSpot = false;
			while { !_goodSpot } do
			{
				_spawnMarker = _availableMarkers call BIS_fnc_selectRandom;
				//Check if there are vehicles/units within 5m (that could prevent the spawn of the veh)
				//If not...
				_goodSpot = true;
			};

			_vehicles = getArray (missionConfigFile >> "AW_rewards" >> _type);
			_veh = _vehicles call BIS_fnc_selectRandom;

			[_veh, (markerPos _spawnMarker), (markerDir _spawnMarker)] call AW_fnc_createVehicle;
			["vehicle_reward", (configFile >> "CfgVehicles" >> _veh >> "displayName")] call AW_fnc_showNotification;
			//Should we attach a marker?
		} else {

		};
	};

	case 2:
	{
		//Specified or nearest base
		_type = _this select 0;
		_param = _this select 1;
		_base = if (typeName _param == "ARRAY") then
		{
			[_param] call AW_fnc_findNearestBase
		} else {
			_param
		};

		if (_type in _types) then
		{
			_availableMarkers = [];
			{
				if ([format["%1_spawn_%2_", _base, _type], _x] call BIS_fnc_inString) then
				{
					_availableMarkers = _availableMarkers + [_x];
				};
			} forEach baseSpawns;

			_spawnMarker = ""; _goodSpot = false;
			while { !_goodSpot } do
			{
				_spawnMarker = _availableMarkers call BIS_fnc_selectRandom;
				//Check if there are vehicles/units within 5m (that could prevent the spawn of the veh)
				//If not...
				_goodSpot = true;
			};

			_vehicles = getArray (missionConfigFile >> "AW_rewards" >> _type);
			_veh = _vehicles call BIS_fnc_selectRandom;

			[_veh, (markerPos _spawnMarker), (markerDir _spawnMarker)] call AW_fnc_createVehicle;
			["vehicle_reward", (configFile >> "CfgVehicles" >> _veh >> "displayName")] call AW_fnc_showNotification;
			//Should we attach a marker?
		} else {
			//Specific vehicle

			//How do we find out what type it is!!!??!?!?!?!
		};
	};
};