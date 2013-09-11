if (debugMode) exitWith {};

[] call AW_fnc_JIPmarkers;
[] call AW_fnc_JIPactions;
if (PARAMS_restrictWeapons == 1) then { [] call AW_fnc_restrictWeapons; };
[] call AW_fnc_setRadioChannels;