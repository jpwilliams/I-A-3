private ["_allItems", "_class", "_lastIndex", "_i", "_role", "_items", "_restricted", "_primary", "_secondary", "_base", "_x", "_name"];

_allItems = [];
_restricted = [];
_lastRole = "";
_currentRole = "";

_class = missionConfigFile >> "CfgRespawnInventory";
_lastIndex = ((count _class) - 1);

for "_i" from 0 to _lastIndex do
{
	_role = _class select _i;
	_items = getArray (_role >> "restrictions");

	{
		if (!(_x in _allItems)) then
		{
			_allItems = _allItems + [_x];
		};
	} forEach _items;
};

while { true } do
{
	sleep 2;

	_currentRole = player getVariable ["role", "none"];

	if (_lastRole != _currentRole) then
	{
		_lastRole = _currentRole;
		_safeItems = getArray (missionConfigFile >> "CfgRespawnInventory" >> _lastRole >> "restrictions");
		_restricted = (_allItems - _safeItems);
	};

	_primary = primaryWeapon player;
	_secondary = secondaryWeapon player;
	_backpack = backpack player;
	_uniform = uniform player;
	_headgear = headgear player;

	{
		_item = _x select 0;
		_config = _x select 1;
		_command = _x select 2;

		_class = configName (inheritsFrom (configFile >> _config >> _item));
		_base = configName (inheritsFrom (configFile >> _config >> _class));

		if ((_item in _restricted) || (_class in _restricted) || (_base in _restricted)) then
		{
			call compile format["%1", _command];

			_name = getText (configFile >> _config >> _item >> "displayName");
			hint parseText format["<t color='#FF0000' size='2.2'>Restricted<br/>Item</t><br/>--------------------<br/>You class you have selected is not qualified to use the %1.<br/><br/>Make sure to play your class!", _name];
		};
	} forEach
	[
		[_primary, "CfgWeapons", "player removeWeapon _item"],
		[_secondary, "CfgWeapons", "player removeWeapon _item"],
		[_backpack, "CfgBackpacks", "removeBackpack player"],
		[_uniform, "CfgWeapons", "removeUniform player"],
		[_headgear, "CfgWeapons", "removeHeadgear player"]
	];
};