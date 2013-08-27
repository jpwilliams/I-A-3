/*
	@version: 1.4
	@file_name: fn_mainInit.sqf
	@file_author: TAW_Tonic
	@file_edit: 7/11/2013
	@file_description: Only called once during the initialization of VAS and uses compileFinal on all VAS functions.
*/
[] spawn
{
	private["_handle"];
	VAS_init_complete = false;
	diag_log "::VAS:: Loading KRON_Strings.sqf";
	_handle = [] execVM "VAS\KRON_Strings.sqf";
	waitUntil {scriptDone _handle};
	diag_log "::VAS:: Loading config.sqf";
	_handle = [] execVM "VAS\config.sqf";
	waitUntil {scriptDone _handle;};
	diag_log "::VAS:: Building VAS Configs";
	if(isNil "VAS_fnc_buildConfig") exitWith {diag_log "::VAS:: function VAS_fnc_buildConfig is nil"};
	["CfgWeapons"] call VAS_fnc_buildConfig;
	["CfgMagazines"] call VAS_fnc_buildConfig;
	["CfgVehicles"] call VAS_fnc_buildConfig;
	["CfgGlasses"] call VAS_fnc_buildConfig;
	VAS_init_complete = true;
};