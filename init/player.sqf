if (debugMode) exitWith {};

waitUntil { !isNil "serverInitComplete" };

//Marker and action syncing
if (isNull player) then
{
	[] call AW_fnc_JIPmarkers;
	[] call AW_fnc_JIPactions;
} else {
	localMarkers = [];	
};

//Roles / weapon restrictions
if (PARAMS_restrictWeapons == 1) then
{	
	waitUntil { !isNil "VAS_init_complete" && VAS_init_complete };
	[] call AW_fnc_getRoleItems;
};

//Radio channels
[] call AW_fnc_setRadioChannels;

//Pilot restrictions
if (PARAMS_pilotRestrictions > 0) then
{
	player addEventHandler
	[
		"GetIn",
		{
			_veh = _this select 0;
			if ((_veh isKindOf "Helicopter" && !(_veh isKindOf "ParachuteBase")) || _veh isKindOf "Plane") then
			{
				if ((_this select 1) == "driver") then
				{
					_canFly = switch (PARAMS_pilotRestrictions) do
					{
						case 1: //Pilots only
						{
							_role = player getVariable ["role", "none"];
							if (!(_role == "pilot")) then
							{
								"a pilot"
							} else {
								""
							};
						};

						case 2:
						{
							_isAdmin = serverCommandAvailable "#kick";
							if (!_isAdmin) then
							{
								"an administrator"
							} else {
								""
							};
						};

						case 3:
						{
							_role = player getVariable ["role", "none"];
							_isAdmin = serverCommandAvailable "#kick";
							if (!(_role == "pilot") && !_isAdmin) then
							{
								"either a pilot or an administrator"
							} else {
								""
							};
						};

						default { "" };
					};

					if (!(_canFly == "")) then
					{
						player action ["eject", _veh];
						waitUntil { vehicle player == player };
						player action ["engineOff", _veh];
						_name = "GET VEHICLE NAME HERE";
						hint parseText format["<t color='#FF0000' size='2.2'>Restricted<br/>Vehicle</t><br/>--------------------<br/>You're not qualified to fly the %1; you must be %2!", _name, _canFly];
					};
				};
			};
		}
	];
};