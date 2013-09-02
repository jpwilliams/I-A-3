/*
	File:	fn_setBehaviour.sqf
	Author:	Rarek [AW]

	Description
		|	Sets behaviour of the given array of groups / units according
		|	to a set of passed parameters.
		|
		|	Behaviours are currently limited to 4 "types" which can be
		|	customised in regards to their positioning and radius.
		|____________________

	Parameters
		|	0 - Units / groups to be controlled
		|			-	REQUIRED
		|			-	TYPE:		Array
		|			-	DEFAULT:	None
		|
		|	1 - Behaviours to perform
		|			-	REQUIRED
		|			-	TYPE:		Array
		|			-	DEFAULT:	None
		|____________________


	Example
		|	_enemies = ["O_soldier_F", group player, ["More", "Soldiers", "Here"]];
		|	_behaviours = [["defend", _pos, _radius], ["patrol", _pos, _radius]];
		|	[_enemies, _behaviours] call AW_fnc_setBehaviour;
		|____________________
*/

private["_obj", "_behaviours", "_type", "_x", "_behaviour", "_order", "_pos", "_radius", "_near", "_leader", "_group", "_dir", "_retreatPos", "_waypoint"];

_obj = if (typeName (_this select 0) == "ARRAY") then { _this select 0 } else { [_this select 0] };
_behaviours = _this select 1;

{
	_type = typeName _x;
	switch (_type) do
	{
		case "ARRAY": { [_x, _behaviours] call AW_fnc_setBehaviour; };

		default
		{
			_behaviour = _behaviours call BIS_fnc_selectRandom;
			_order = _behaviour select 0;
			_pos = [0,0,0];




			if (typeName (_behaviour select 1) == "ARRAY") then
			{
				_pos = _behaviour select 1;
			} else {
				if (typeName _x == "GROUP") then
				{
					_pos = getPos (leader _x);
				} else {
					_pos = getPos _x;
				};

				if (typeName _x == "STRING") then
				{
					_pos = [_x, ((markerSize _x) call BIS_fnc_lowestNum)] call AW_fnc_randomPosTrigger;
				};
			};
			_radius = if (count _behaviour > 2) then { _behaviour select 2 } else { 100 };
			switch (_order) do
			{
				case "defend":
				{
					_near = [[[_pos, _radius]], ["water", "out"]] call BIS_fnc_randomPos;
					[_x, _near] call BIS_fnc_taskDefend;
				};

				case "active_defend":
				{
					_near = [[[_pos, _radius]], ["water", "out"]] call BIS_fnc_randomPos;
					[_x, _near] call BIS_fnc_taskDefend;
					_x setBehaviour "AWARE";
					_x setSpeedMode "FULL";
				};

				case "patrol": { [_x, _pos, _radius] call BIS_fnc_taskPatrol; };

				case "attack": { [_x, _pos] call BIS_fnc_taskAttack; };

				case "retreat":
				{
					_leader = if (_type == "GROUP") then { leader _x } else { _x };
					_group = if (_type == "GROUP") then { _x } else { group _x };
					_dir = [_pos, getPos _leader] call BIS_fnc_dirTo;
					_retreatPos = [];
					while {true} do
					{
						_retreatPos = [_pos, _radius, _dir] call BIS_fnc_relPos;
						if (!(surfaceIsWater [(_retreatPos select 0), (_retreatPos select 1)])) exitWith {};
						_dir = if ((_dir + 45) > 359) then { 0 } else { (_dir + 45) };
					};

					_waypoint = _group addWaypoint [_retreatPos, 0];
					_waypoint setWaypointType "MOVE";
					_waypoint setWaypointBehaviour "AWARE";
					_waypoint setWaypointCombatMode "GREEN";
					_waypoint setWaypointSpeed "FULL";
					_group setCurrentWaypoint _waypoint;
				};
			};
		};
	};
} forEach _obj;