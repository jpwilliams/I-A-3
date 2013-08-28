_localActions = JIPactions;

{
	_obj	=	(_x select 0) select 1;
	_params	=	_x select 1;

	_obj addAction _params;
} forEach _localActions;
