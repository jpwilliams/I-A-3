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

_obj = [_this,0,[],[[],objNull,grpNull]] call BIS_fnc_param;
if (typeName _obj == "OBJECT") then { _obj = [group _obj]; };
if (typeName _obj == "GROUP") then { _obj = [_obj]; };
_behaviours = [_this,1,[["patrol", true, 100]],[[]]] call BIS_fnc_param;

{
	_type = typeName _x;
	switch (_type) do
	{
		case "ARRAY": { [_x, _behaviours] call AW_fnc_setBehaviour; };

		default
		{
			_behaviour = _behaviours call BIS_fnc_selectRandom;
			_order = [_behaviour,0,"patrol",[""]] call BIS_fnc_param;
			_pos = [_behaviour,1,[0,0,0],[[],"",true],[2,3]] call BIS_fnc_param;

			if (typeName _pos == "BOOL") then
			{
				if (_type == "GROUP") then { _pos = getPos (leader _x); };
				if (_type == "OBJECT") then { _pos = getPos _x; };
			};

			if (typeName _pos == "STRING") then
			{
				_pos = [_pos, ((markerSize _pos) call BIS_fnc_lowestNum)] call AW_fnc_randomPosTrigger;
			};

			_radius = [_behaviour,2,100,[0]] call BIS_fnc_param;

			switch (_order) do
			{
				case "defend":
				{
					_group = if (_type == "GROUP") then { _x } else { group _x };

					_near = [[[_pos, _radius]], ["water", "out"]] call BIS_fnc_randomPos;
					[_group, _near] call BIS_fnc_taskDefend;
				};

				case "active_defend":
				{
					_group = if (_type == "GROUP") then { _x } else { group _x };

					_near = [[[_pos, _radius]], ["water", "out"]] call BIS_fnc_randomPos;
					[_group, _near] call BIS_fnc_taskDefend;
					_x setBehaviour "AWARE";
					_x setSpeedMode "FULL";
				};

				case "patrol":
				{
					_group = if (_type == "GROUP") then { _x } else { group _x };

					_didWork = false;
					_attempt_limit = 10;
					_attempts = 0;

					while { !_didWork && _attempts < _attempt_limit } do
					{
						_attempts = _attempts + 1;
						_didWork = [_group, _pos, _radius] call BIS_fnc_taskPatrol;
						diag_log format["::::AW:::: _x = %1 :::: _pos = %2 :::: _radius = %3 :::: _didWork = %4", _x, _pos, _radius, _didWork];
					};

					if (!_didWork) then
					{
						_x setFormation "DIAMOND";
					};
				};

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