//onPlayerRespawn.sqf

private ["_role", "_safeItems"];

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

player addEventHandler
[
	"Take", 
	{
		private ["_obj", "_tmp"];

		_obj = _this select 2;

		if (_obj in restricted) then
		{
			_tmp = false;

			while { !_tmp } do
			{
				_tmp = true;

				if (_obj == primaryWeapon player || _obj == secondaryWeapon player) exitWith { player removeWeapon _obj; };
				if (_obj == backpack player) exitWith { removeBackpack player; };
				if (_obj == uniform player) exitWith { removeUniform player; };
				if (_obj == headgear player) exitWith { removeHeadgear player; };
				if (_obj in (items player)) exitWith { player removeItem _obj; };
			};

			hint parseText "<t color='#FF0000' size='2.2'>Restricted<br/>Item</t><br/>--------------------<br/>The class you have selected is not qualified to use that item.<br/><br/>Make sure to play your class!";
		};
	}
];