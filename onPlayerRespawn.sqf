//onPlayerRespawn.sqf

restricted = [];

waitUntil { alive player };
_role = player getVariable ["role", "none"];

_safeItems = getArray (missionConfigFile >> "CfgRespawnInventory" >> _role >> "restrictions");
restricted = (allItems - _safeItems);

VAS_pre_weapons = VAS_pre_weapons_original - restricted;
VAS_pre_magazines = VAS_pre_magazines_original - restricted;
VAS_pre_items = VAS_pre_items_original - restricted;
VAS_pre_backpacks = VAS_pre_backpacks_original - restricted;
VAS_pre_glasses = VAS_pre_glasses_original - restricted;

player addEventHandler ["Take", {
	if ((_this select 2) in restricted) then
	{
		hint parseText "<t color='#FF0000' size='2.2'>Restricted<br/>Item</t><br/>--------------------<br/>You class you have selected is not qualified to use that item.<br/><br/>Make sure to play your class!";
	};
}];