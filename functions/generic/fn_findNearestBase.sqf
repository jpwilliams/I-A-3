_pos = _this select 0;
_min = 1e9;
_base = "";

{
	_dist = ((markerPos _x) distance _pos);
	if (_dist < _min) then { _min = _dist; _base = _x; };
} forEach basesOwned;

_base