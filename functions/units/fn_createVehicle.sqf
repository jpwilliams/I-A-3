private ["_type", "_pos", "_obj"];

_type = _this select 0;
_pos = _this select 1;

_obj = _type createVehicle _pos;
_obj addEventHandler ["killed", { /* do something fantastic */ }];

_obj