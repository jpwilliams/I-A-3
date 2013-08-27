_type		=	_this select 0;
_mission	=	_this select 1;
_code		=	_this select 2;
_pos		=	_this select 3;

_fsmHandle = [_pos, _code] execFSM format["missions\%1\%2\mission.fsm", _type, _mission];

_fsmHandle