private ["_allItems", "_class", "_count", "_i", "_role", "_items", "_restricted", "_primary", "_secondary", "_base", "_x", "_name"];

_allItems = [];
_class = (missionConfigFile >> "CfgRespawnInventory");
_count = (count _class) - 1;

for "_i" from 0 to _count do
{
	_role = _class select _i;
	_items = 	getArray (_role >> "items");
	_allItems = _allItems + _weapons;
};

while { true } do
{
	sleep 2;

	role = player getVariable ["role", "none"];

	//Primary and secondary weapons
	/*
		The command below needs to be corrected to remove ALL instances of the player's role weapons.
		This may be able to be done using a BIS function?
	*/
	_restricted = (_allItems - (getArray (missionConfigFile >> "CfgRespawnInventory" >> role >> "items")));

	_primary = primaryWeapon player;
	_secondary = secondaryWeapon player;
	_backpack = backpack player;

	{
		_item = _x select 0;
		_config = _x select 1;

		_class = configName (inheritsFrom (configFile >> _config >> _item));
		_base = configName (inheritsFrom (configFile >> _config >> _class));

		if ((_item in _restricted) || (_class in _restricted) || (_base in _restricted)) then
		{
			player removeWeapon _item;
			//Needs alternative command for restricted backpack removal
			_name = getText (configFile >> _config >> _item >> "displayName");
			hint parseText format["<t color='#FF0000' size='2.2'>Restricted<br/>Item</t><br/>--------------------<br/>You class you have selected is not qualified to use the %1.<br/><br/>Make sure to play your class!", _name];
		};
	} forEach [[_primary, "CfgWeapons"], [_secondary, "CfgWeapons"], [_backpack, "CfgBackpacks"]];
};