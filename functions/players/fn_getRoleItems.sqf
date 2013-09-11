private ["_class", "_lastIndex", "_i", "_role", "_items", "_restricted", "_primary", "_secondary", "_base", "_x", "_name"];

allItems = [];
restricted = [];
VAS_pre_weapons_original = VAS_pre_weapons;
VAS_pre_magazines_original = VAS_pre_magazines;
VAS_pre_items_original = VAS_pre_items;
VAS_pre_backpacks_original = VAS_pre_backpacks;
VAS_pre_glasses_original = VAS_pre_glasses;

_class = missionConfigFile >> "CfgRespawnInventory";
_lastIndex = ((count _class) - 1);

for "_i" from 0 to _lastIndex do
{
	_role = _class select _i;
	_items = getArray (_role >> "restrictions");

	{
		if (!(_x in allItems)) then
		{
			allItems = allItems + [_x];
		};
	} forEach _items;
};