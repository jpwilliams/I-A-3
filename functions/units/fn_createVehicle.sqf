private ["_type", "_pos", "_obj"];

_type = [_this,0,"",[""]] call BIS_fnc_param;
_pos = [_this,1,[0,0,0],[[]],[2,3]] call BIS_fnc_param;
_dir = [_this,2,false,[0]] call BIS_fnc_param;

_obj = _type createVehicle _pos;
_obj setPos _pos;
_obj addEventHandler ["killed", { (_this select 0) call AW_fnc_addDead; }];
if (typeName _dir == "SCALAR") then { _obj setDir _dir; };

_obj