private ["_this", "_type", "_mission", "_code", "_pos", "_fsmHandle"];

_type = [_this,0,"",[""]] call BIS_fnc_param;
_mission = [_this,1,"",[""]] call BIS_fnc_param;
_code = [_this,2,"",[""]] call BIS_fnc_param;
_pos = [_this,3,[0,0,0],[[]],[2,3]] call BIS_fnc_param;

_fsmHandle = [_pos, _code] execFSM format["missions\%1\%2\mission.fsm", _type, _mission];

_fsmHandle