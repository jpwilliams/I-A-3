#include "macro.sqf"
/*
	@version: 1.1
	@file_name: fn_deleteGear.sqf
	@file_author: TAW_Tonic
	@file_edit: 5/27/2013
	@file_description: Deletes a saved slot and prompts if you actually want to delete it.
*/
private["_slot","_data"];
_slot = lbCurSel VAS_load_list;
if(_slot == -1) exitWith {hint "You didn't select a slot to delete!"};
if(vas_disableLoadSave) then
{
	_data = missionNamespace getVariable format["vas_gear_new_%1",_slot];
}
	else
{
	_data = profileNameSpace getVariable format["vas_gear_new_%1",_slot];
};

if(isNil {_data}) exitWith {hint "You can't delete that slot, it has no information!"};
createDialog "VAS_prompt";
disableSerialization;

waitUntil {!isNull (findDisplay VAS_prompt_Display)};
(VAS_getControl(VAS_prompt_Display,VAS_prompt_text)) ctrlSetStructuredText parseText format["<t align='center'><t size='.8px'>You are about to delete slot %1</t></t><br/><t align='center'><t size='2px'>%2</t></t>",_slot+1,_data select 0];
(VAS_getControl(VAS_prompt_Display,VAS_prompt_true)) ctrlSetText "Yes";
(VAS_getControl(VAS_prompt_Display,VAS_prompt_false)) ctrlSetText "No";

waitUntil {!isNil {vas_prompt_choice}};

if(vas_prompt_choice) then
{
	if(vas_disableLoadSave) then
	{
		hint format["You deleted slot:\n%1",(missionNamespace getVariable format["vas_gear_new_%1",_slot]) select 0];
		missionNamespace setVariable[format["vas_gear_new_%1",_slot],nil];
		[1,true] spawn VAS_fnc_SaveLoad;
		vas_prompt_choice = nil;
	}
		else
	{
		hint format["You deleted slot:\n%1",(profileNameSpace getVariable format["vas_gear_new_%1",_slot]) select 0];
		profileNameSpace setVariable[format["vas_gear_new_%1",_slot],nil];
		saveProfileNamespace;
		[1,true] spawn VAS_fnc_SaveLoad;
		vas_prompt_choice = nil;
	};
}
	else
{
	vas_prompt_choice = nil;
	hint format["You cancelled deleting slot %1",_slot+1];
};