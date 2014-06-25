if (debugMode) exitWith {};

/*******************************************************************\

	You may, of course, remove this if you wish.

	*/
		//onPlayerConnected "if (_uid == 76561197979546789) then { cutText [""Rarek, creator of Invade & Annex, has joined the server."", ""PLAIN""]; };";
	/*

	I just thought it'd be a humorous touch seeing as I put a lot
	of work in. :)

\*******************************************************************/

allBases = []; basesOwned = []; baseSpawns = [];
JIPmarkers = []; publicVariable "JIPmarkers"; localMarkers = [];
JIPactions = []; publicVariable "JIPactions";
result = false;
AW_dead = [];

_paramCount = count paramsArray;
for [ {_i = 0}, {_i < _paramCount}, {_i = _i + 1} ] do
{
	call compile format
	[
		"PARAMS_%1 = %2;",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

//PV the vars we need players to see
publicVariable "PARAMS_restrictWeapons";
publicVariable "PARAMS_pilotRestrictions";

//Set time
skipTime (PARAMS_startTimeHour + PARAMS_startTimeMinutes);

//Grab points of interest
pointsOfInterest = [];
{
	if (["poi_", _x] call BIS_fnc_inString) then
	{
		pointsOfInterest = pointsOfInterest + [_x];
	};
} forEach allMapMarkers;

//Set up radio channels
[] call AW_fnc_setRadioChannels;

/*******************************************************************\

	RESPAWN INVENTORIES START

		_inventories = missionConfigFile >> "CfgRespawnInventory";
		_lastIndex = ((count _inventories) - 1);

		for "_i" from 0 to _lastIndex do
		{
			_x = _inventories select _i;
			_name = configName _x;
			[WEST, format["%1", _name]] call BIS_fnc_addRespawnInventory;
		};

	RESPAWN INVENTORIES FINISH

	*/

	//Horrendous work-around for weird cfg issue
	[WEST, "standard"] call BIS_fnc_addRespawnInventory;
	[WEST, "medic"] call BIS_fnc_addRespawnInventory;
	[WEST, "sniper"] call BIS_fnc_addRespawnInventory;
	[WEST, "aa"] call BIS_fnc_addRespawnInventory;
	[WEST, "at"] call BIS_fnc_addRespawnInventory;
	[WEST, "engineer"] call BIS_fnc_addRespawnInventory;
	[WEST, "grenadier"] call BIS_fnc_addRespawnInventory;
	[WEST, "autorifleman"] call BIS_fnc_addRespawnInventory;
	[WEST, "ammo"] call BIS_fnc_addRespawnInventory;
	[WEST, "uav"] call BIS_fnc_addRespawnInventory;
	[WEST, "pilot"] call BIS_fnc_addRespawnInventory;
	[WEST, "explosives"] call BIS_fnc_addRespawnInventory;

	/*

\*******************************************************************/ 


/*******************************************************************\

	BASES START

	*/
		_bases = missionConfigFile >> "AW_base";
		_lastIndex = ((count _bases) - 1);

		for "_i" from 0 to _lastIndex do
		{
			_x = _bases select _i;

			[
				["name", getText (_x >> "name")],
				["isOwned", getNumber (_x >> "isOwned")],
				["marker", configName _x],
				["groups", getNumber (_x >> "groups")],
				["respawnGroups", getNumber (_x >> "respawnGroups")],
				["respawnTime", getNumber (_x >> "respawnTime")],
				["vehicles", getArray (_x >> "vehicles")]
			] execFSM "machines\base.fsm";
		};
	/*

	BASES FINISH

\*******************************************************************/

/*******************************************************************\

	MAIN START

	*/
		_locs = ["AW_main"] call BIS_fnc_getCfgSubClasses;
		[_locs] execFSM "machines\main.fsm";
	/*

	MAIN FINISH

\*******************************************************************/


/*******************************************************************\

	MISSIONS START

	*/
		{
			_param = 0;
			call compile format["_param = PARAMS_%1MissionsEnabled;", _x];
			if (_param == 1) then
			{
				_amount = 1;
				call compile format["_amount = PARAMS_%1Number;", _x];
				for "_i" from 1 to _amount do
				{
					[_x, [], true] execFSM "machines\mission.fsm";
				};
			};
		} foreach ["tactical", "ghost", "priority"];
	/*

	MISSIONS FINISH

\*******************************************************************/

serverInitComplete = true;
publicVariable "serverInitComplete";
