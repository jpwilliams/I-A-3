if (debugMode) exitWith {};

basesOwned = 0;
JIPmarkers = []; publicVariable "JIPmarkers"; localMarkers = [];
JIPactions = []; publicVariable "JIPactions";
result = false;
AW_dead = [];

_paramCount = count paramsArray;
for [ {_i = 0}, {_i < _paramCount}, {_i = _i + 1} ] do
{
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};


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
				["radius", getNumber (_x >> "radius")],
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