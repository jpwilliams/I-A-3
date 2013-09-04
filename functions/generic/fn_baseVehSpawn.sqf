//_reward = ["HEMTT", _nearestBase] call AW_fnc_rewardSpawn; 	// Spawn HEMTT at specified base
//_reward = ["HEMTT", [255,234,10]] call AW_fnc_rewardSpawn; 	// Spawn HEMTT at nearest base to _pos
//_reward = ["HEMTT"] call AW_fnc_rewardSpawn;					// Spawn HEMTT at random base
//_reward = ["land"] call AW_fnc_rewardSpawn;					// Spawn land vehicle at random base
//_reward = ["air"] call AW_fnc_rewardSpawn;					// Spawn air vehicle at random base
//_reward = [] call AW_fnc_rewardSpawn;							// Spawn a random reward at a random base

_type = [_this,0,"",[""]] call BIS_fnc_param;
_base = [_this,1,"",["",[]]] call BIS_fnc_param;
_veh = "";
_marker = "";

//Get reward types from config file
_types = []; _allVehs = [];
_class = (missionConfigFile >> "AW_rewards"); _count = count _class;
for "_i" from 0 to _count do
{
	_tmp = (_class select _i);
	_type = (configName _tmp);
	_types = _types + [_type];

	_vehs = getArray _tmp;
	{
		_allVehs = _allVehs + [[_type, _x]];
	} forEach _vehs;
};

//Get type and vehicle
if (_type == "") then
{
	//Select a random vehicle
	_tmp = _allVehs call BIS_fnc_selectRandom;
	_type = _tmp select 0;
	_veh = _tmp select 1;
} else {
	//Is it a class or a type?
	if (!(_type in _types)) then
	{
		//Class
		_veh = _type;
		_class = getText (configFile >> "CfgVehicles" >> _veh >> "vehicleClass");

		if (_class == "Armored" || _class == "Car" || _class == "Static") then
		{
			_type = "land";
		} else {
			if (_class == "Air" || _class == "Autonomous") then
			{
				_type = "air";
			} else {
				_type = "sea";
			};
		};
	} else {
		//Type
		_vehs = getArray (missionConfigFile >> "AW_rewards" >> _type);
		_veh = _vehs call BIS_fnc_selectRandom;
	};
};

//Get type markers
_markers = []
{
	if ([format["_%1", _type], _x] call BIS_fnc_inString) then
	{
		_markers = _markers + [_x];
	};
} forEach baseSpawns;

//Sort bases
if (_base == "") then
{
	//Use any random marker!
	_marker = _markers call BIS_fnc_selectRandom;
} else {
	//Needs to be a specific base!
	if (typeName _base == "ARRAY") then
	{
		_base = [_base] call AW_fnc_findNearestBase;
	};

	_tmp = _markers;
	{
		if (!([_base, _x] call BIS_fnc_inString)) then
		{
			_markers = _markers - [_x];
		} else {
			//Check here if there's anything blocking the spawn point
			//If yes, remove this marker from the available array
			if (false) then
			{
				_markers = _markers - [_x];
			};
		};
	} forEach _tmp;

	_marker = _markers call BIS_fnc_selectRandom;
};

//Spawn vehicle!
_obj = [_veh, (markerPos _marker), (markerDir _marker)] call AW_fnc_createVehicle;

_obj