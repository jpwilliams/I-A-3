private ["_type", "_base", "_types", "_allVehs", "_class", "_lastIndex", "_tmp_class", "_tmp_type","_vehicles", "_x", "_veh", "_marker", "_markerPos", "_markers", "_exhaustedTypes", "_exhaustedBases", "_done", "_success"];

_type = [_this,0,"",[""]] call BIS_fnc_param;
_base = [_this,1,"",["",[],objNull],[2,3]] call BIS_fnc_param;
if (typeName _base == "OBJECT") then { _base = getPos _base; };

_types = [];
_allVehs = [];

_class = (missionConfigFile >> "AW_rewards");
_lastIndex = ((count _class) - 1);

for "_i" from 0 to _lastIndex do
{
	_tmp_class = (_class select _i);
	_tmp_type = (configName _tmp_class);
	_types = _types + [_tmp_type];

	_vehicles = getArray _tmp_class;
	{
		_allVehs = _allVehs + [[_tmp_type, _x]];
	} forEach _vehicles;
};

_veh = "";
_marker = "";
_markerPos = [];
_markers = [];
_exhaustedTypes = [];
_exhaustedBases = [];

_done = false;
_success = false;

while { !_done } do
{
	_skipCheck = false;

	//Get type and vehicle
	if (_type == "") then
	{
		//Nothing specified; grab a random vehicle
		_tmp = _allVehs call BIS_fnc_selectRandom;

		_type = _tmp select 0;
		_veh = _tmp select 1;
	} else {
		if (_type in _types) then
		{
			_tmp = getArray (missionConfigFile >> "AW_rewards" >> _type);
			_veh = _tmp call BIS_fnc_selectRandom;
		} else {
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
		};
	};

	//Get available markers
	{
		if ([format["_%1", _type], _x] call BIS_fnc_inString) then
		{
			_markers = _markers + [_x];
		};
	} forEach baseSpawns;

	//Get base intended
	if (typeName _base == "ARRAY" || _base in _exhaustedBases) then
	{
		_base = [_base, _exhaustedBases] call AW_fnc_findNearestBase;
	} else {
		_tmp = _markers;
		
		{
			if (!([_base, _x] call BIS_fnc_inString)) then
			{
				_markers = _markers - [_x];
			};
		} forEach _tmp;
	};

	//Find some valid markers
	while { (count _markers) > 0 } do
	{
		if (_type in _exhaustedTypes) exitWith
		{
			_type = "";
			_skipCheck = true;
		};

		_marker = _markers call BIS_fnc_selectRandom;
		if (isNil "_marker") then { _marker = ""; };

		if (_marker != "") then
		{
			_markerPos = markerPos _marker;

			{
				if ((_x distance _markerPos) < 5) exitWith
				{
					_markers = _markers - [_marker];
					_marker = "";
				};
			} forEach vehicles;

			if (_marker != "") exitWith
			{
				_skipCheck = true;
				_done = true;
				_success = true;
			};
		};
	};

	//Final exhaustion checks
	if (!_skipCheck) then
	{
		_done = true;
		_exhaustedAllTypes = true;

		_exhaustedTypes = _exhaustedTypes + [_type];

		_type = [_this,0,"",[""]] call BIS_fnc_param;
		if (_type == "") then
		{
			{
				if (!(_x in _exhaustedTypes)) exitWith { _exhaustedAllTypes = false; };
			} forEach _types;
		};

		if (_exhaustedAllTypes) then
		{
			_exhaustedBases = _exhaustedBases + [_base];
			_exhaustedTypes = [];

			{
				if (!(_x in _exhaustedBases)) exitWith { _done = false; };
			} forEach basesOwned;
		} else {
			_done = false;
		};

		_veh = "";
		_marker = "";
	};
};

_ret = if (_success) then
{
	[_veh, _markerPos, (markerDir _marker)] call AW_fnc_createVehicle
} else {
	objNull	
};

_ret