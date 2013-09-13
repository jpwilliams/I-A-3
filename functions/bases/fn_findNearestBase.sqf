private ["_this", "_pos", "_blacklist", "_min", "_base", "_dist"];

_pos = [_this,0,[0,0,0],[[],objNull],[2,3]] call BIS_fnc_param;
_blacklist = [_this,1,[],[[]]] call BIS_fnc_param;
_side = [_this,2,"",[WEST]] call BIS_fnc_param;
if (typeName _pos == "OBJECT") then { _pos = getPos _pos; };
_min = 1e9;
_base = "";

{
	_dist = ((markerPos _x) distance _pos);
	if (_dist < _min && !(_x in _blacklist)) then
	{
		if (typeName _side != "STRING") then
		{
			if (_side == WEST && _x in basesOwned) then
			{
				_min = _dist;
				_base = _x;
			}
			else if (!(_x in basesOwned)) then
			{
				_min = _dist;
				_base = _x;
			};
		} else {
			_min = _dist;
			_base = _x;
		};
	};
} forEach allBases;

_base
