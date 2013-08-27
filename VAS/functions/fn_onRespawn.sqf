#include "macro.sqf"
/*
	@version: 1.0
	@file_name: load_onrespawn.sqf
	@file_author: TAW_Tonic
	@file_edit: 5/23/2013
*/
VAS_slot = lbCurSel VAS_load_list;
if(VAS_slot == -1) exitWith {hint "No slot was selected to be loaded upon respawn!"};
player RemoveallEventHandlers "Respawn";
player addEventHandler ["Respawn", {[VAS_slot] spawn VAS_fnc_loadGear;}];