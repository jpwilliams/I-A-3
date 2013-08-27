if(isNil "VAS_init_complete") exitWith {hint "VAS never initialized, something went wrong?";};
if(!VAS_init_complete) exitWith {hint "VAS hasn't finished loading yet."};
createDialog "VAS_Diag";
disableSerialization;

ctrlShow [2507,false];
ctrlShow [2508,false];
ctrlShow [2509,false];