#include "macro.sqf"
/*
	@version: 1.0
	@file_name: add_gear.sqf
	@file_author: TAW_Tonic
	@file_edit: 5/23/2013
	@file_description: Adds an item selected.
*/
private["_data","_handle"];
disableSerialization;

_data = VAS_getSelData(VAS_virt_list);
_handle = [_data,true,nil,nil,nil] spawn VAS_fnc_handleItem;
waitUntil {scriptDone _handle};
[] spawn VAS_fnc_playerDisplay;