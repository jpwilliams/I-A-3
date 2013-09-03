private ["_type", "_pos", "_obj"];

_type = _this select 0;
_pos = _this select 1;
_dir = if ((count _this) > 2) then { _this select 2 } else { "" };

_obj = _type createVehicle _pos;
_obj addEventHandler ["killed", { (_this select 0) call AW_fnc_addDead; }];
if (typeName _dir == "SCALAR") then { _obj setDir _dir; };

_obj