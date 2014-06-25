if (!isServer) exitWith {};

//Define parameters
_unit_class = [_this,0,"",[""]] call BIS_fnc_param;
_respawn_marker = [_this,1,"",[""]] call BIS_fnc_param;
_base_marker = [_this,2,"",[""]] call BIS_fnc_param;
_respawn_delay = [_this,3,30,[0,[]]] call BIS_fnc_param; //array not yet implemented
_deserted_delay = [_this,4,300,[0,[]]] call BIS_fnc_param; //array not yet implemeneted
_respawn_marker_tag = ""; //Add in a placeholder for our tag marker

//Weed out the crap
if (_unit_class == "" || _respawn_marker == "") exitWith {};

//Define the functions we'll be using quickly
_FUNC_create_unit = {
	//Get params given
	_unit_class = [_this,0,false,[""]] call BIS_fnc_param;
	_respawn_marker = [_this,1,"",[""]] call BIS_fnc_param;
	_pos = [_this,2,[0,0,0],[[]]] call BIS_fnc_param;
	_dir = [_this,3,0,[0]] call BIS_fnc_param;
	_unit_name = [_this,4,"",[""]] call BIS_fnc_param;

	//Create our unit!
	_unit = _unit_class createVehicle _pos; //Don't create via AW_fnc_createVehicle as we're handling the dead stuff here
	_unit setDir _dir;

	//Make sure they're where they should be...
	_unit setPos _pos;

	//Add AI to UAVs!
	if (["B_UAV", _unit_class] call BIS_fnc_inString) then
	{
		createVehicleCrew _unit;
	};

	//Set up our respawn tags (but we can't return these yet!)
	_respawn_marker_tag = [["veh_respawn", "at_base"], _respawn_marker, _pos, _unit_name] call AW_fnc_createJIPstateMarker;

	//Return the unit
	_unit
};

_FUNC_get_approx_distance = {
	//Get params
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_respawn_marker = [_this,1,"",[""]] call BIS_fnc_param;

	//Get the position of our unit and marker
	_unit_pos = getPos _unit;
	_marker_pos = getMarkerPos _respawn_marker;

	//Calculate the approx distance!
	_distance = _unit_pos distance _marker_pos;

	_approx_distance = switch (true) do //probably a much more elegant way of doing this, but pressed for time!
	{
		case (_distance > 25000): { 25000 };
		case (_distance > 20000): { 20000 };
		case (_distance > 15000): { 15000 };
		case (_distance > 10000): { 10000 };
		case (_distance > 5000): { 5000 };
		case (_distance > 2500): { 2500 };
		case (_distance > 1000): { 1000 };
		case (_distance > 500): { 500 };
		case (_distance > 250): { 250 };
		case (_distance > 100): { 100 };
		default { 0 };
	};

	//If it's 0, set to <100, otherwise just >whatever
	if (_approx_distance == 0) then
	{
		_approx_distance = "(<100m)";
	}
	else
	{
		_approx_distance = format["(>%1m)", _approx_distance];
	};

	_approx_distance
};

//Let's get the marker properties so we can get ready to spawn our vehicle
_pos = getMarkerPos _respawn_marker;
_dir = markerDir _respawn_marker;

//Get the pretty name of our vehicle
_cfg = (configFile >> "CfgVehicles" >> _unit_class);
_unit_name = getText (_cfg >> "DisplayName");

//Create our respawning vehicle
_unit = [_unit_class, _respawn_marker, _pos, _dir, _unit_name] call _FUNC_create_unit;

//Start looping to check for respawns!
_run = true;
_dead = false;
_deserted = false;

while {_run} do
{
	//Wait for it...
	sleep (2 + random 8);

	//Do we still own the base?
	_baseOwned = false;

	{
		if (_x == _base_marker) exitWith
		{
			_baseOwned = true;
		};
	} forEach basesOwned;

	//If not, delete the markers and get outta there!
	if (!_baseOwned) exitWith
	{
		[_respawn_marker_tag] call AW_fnc_deleteMarker;
	};

	//Are we dead?
	if (getDammage _unit > 0.8 && { alive _x } count (crew _unit) == 0) then
	{
		_dead = true;
	};

	if (!_dead && _deserted_delay > 0) then
	{
		//Is the vehicle abandoned?
		if (((getPosASL _unit) distance _pos) > 20 && ({ alive _x } count (crew _unit)) == 0 && (getDammage _unit) < 0.8) then
		{
			//Put that it's away on our tag, seeing as it's most definitely away...
			_approx_distance = [_unit, _respawn_marker] call _FUNC_get_approx_distance;
			_respawn_marker_tag = [["veh_respawn", "in_action"], _respawn_marker, _pos, format["%1 %2", _approx_distance, _unit_name]] call AW_fnc_createJIPstateMarker;

			//And we have been deserted!
			_deserted = true;
		};

		//Looks like it is! Let's wait and see...
		if (_deserted) then
		{
			//Temporarily set _deserted to false for later theory
			_deserted = false;
			_timeout = time + _deserted_delay;
			
			//Wait for either the timer to end, the vehicle to die or someone to get in
			while {_timeout >= time && alive _unit && ({ alive _x } count (crew _unit)) == 0} do
			{
				sleep 1;
			};

			//Did the timer run out?
			if (_timeout < time) then
			{
				_deserted = true;
			};

			//Did we die?
			if (!_deserted && !alive _unit) then
			{
				_dead = true;
			};

			//If someone got in the vehicle, _deserted's already set to false.
		};
	};

	//So... do we start respawning?
	if (_dead || _deserted) then
	{
		//If it's been deserted, we've already waited so let's not wait again!
		if (_deserted) then
		{
			sleep 0.1;
		}
		else
		{
			//Set our marker tag so everyone knows what's up
			_respawn_marker_tag = [["veh_respawn", "destroyed"], _respawn_marker, _pos, _unit_name] call AW_fnc_createJIPstateMarker;

			//Now wait for a bit before we respawn...
			sleep _respawn_delay;
		};

		//Courtesy sleep
		sleep 0.1;

		//Remove the dead/deserted vehicle
		deleteVehicle _unit;

		//Wait for that to process...
		sleep 2;

		//Create our new unit
		_unit = [_unit_class, _respawn_marker, _pos, _dir, _unit_name] call _FUNC_create_unit;

		//Reset our thing-bobs
		_dead = false;
		_deserted = false;
	}
	else //If we're not dead or deserted, set our marker up!
	{
		//Is the vehicle at its spawn?
		if ((_unit distance _pos) < 30) then
		{
			_respawn_marker_tag = [["veh_respawn", "at_base"], _respawn_marker, _pos, _unit_name] call AW_fnc_createJIPstateMarker;
		}
		else //If it ain't let's mark it as away...
		{
			_approx_distance = [_unit, _respawn_marker] call _FUNC_get_approx_distance;
			_respawn_marker_tag = [["veh_respawn", "in_action"], _respawn_marker, _pos, format["%1 %2", _approx_distance, _unit_name]] call AW_fnc_createJIPstateMarker;
		};
	};
};