/*
	File:	fn_JIPactions.sqf
	Author:	Rarek [AW]

	Description
		|	Used to allow JIPPs to create local actions
		|	in place of currently-existing actions.
		|____________________
*/

_localActions = JIPactions;

{
	_obj	=	(_x select 0) select 1;
	_params	=	_x select 1;

	_obj addAction _params;
} forEach _localActions;