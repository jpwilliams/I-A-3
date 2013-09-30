//Tweaked by Rarek [AW] to enable role assignment
//TO-DO: Make selected value check show status before assigning role

disableserialization;

_unit = [_this,0,objnull,[objnull]] call bis_fnc_param;
_respawnDelay = [_this,3,0,[0]] call bis_fnc_param;

if (!alive _unit) then {
	if (playerrespawntime < 1 || !isplayer _unit) exitwith {};
	if (simulationenabled _unit) then {
		if (playerrespawntime < 3) then {setplayerrespawntime (playerrespawntime + 3);};

		sleep 1.9;
		cutText ["","black out",0.5];
		sleep 1;
		cutText ["","black in"];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	//--- onPlayerKilled
	///////////////////////////////////////////////////////////////////////////////////////////

	[
		"Select Loadout",
		{
			scriptname "BIS_fnc_respawnMenuInventory";
			_fnc_scriptName = "BIS_fnc_respawnMenuInventory";

			disableserialization;
			_mode = _this select 0;
			_ctrlListBackground = _this select 1;
			_ctrlList = _this select 2;
			_ctrlContentBackground = _this select 3;
			_ctrlContentGroup = _this select 4;
			_ctrlContent = _this select 5;
			_ctrlMap = _this select 6;

			switch _mode do {
				case "init": {
					_ctrlMap ctrlsetfade 1;
					_ctrlMap ctrlcommit 0;
	
					BIS_fnc_respawnMenuPosition_inventories = [];
				};
				case "select": {

					if (lbsize _ctrlList == 0) exitwith {};

					_selected = _ctrlList lbdata lbcursel _ctrlList;
					if (_selected == missionnamespace getvariable ["BIS_fnc_respawnMenuInventory_selected",""]) exitwith {};

					if (_selected == "") then {
						_text = "<t size='3' shadow='0' color='#33ffffff'> ? </t>???<t align='right'>?</t><br />";
						_ctrlContent ctrlsetstructuredtext parsetext (_text + _text + _text + _text + _text);
						_ctrlContent call bis_fnc_ctrlFitToTextHeight;
					} else {
						_varName = "BIS_fnc_respawnMenuInventory_" + _selected;
						_var = missionnamespace getvariable _varName;
						if !(isnil {_var}) then {
							_text = _var select 2;
							_ctrlContent ctrlsetstructuredtext _text;
							_ctrlContent call bis_fnc_ctrlFitToTextHeight;
						};
					};
					BIS_fnc_respawnMenuInventory_selected = _selected;
				};
				case "update": {
					_selected = _ctrlList lbdata lbcursel _ctrlList;
					if (_selected == "") then {_selected = missionnamespace getvariable ["BIS_fnc_respawnMenuInventory_selected",""];};

					_respawnInventories = player call bis_fnc_getRespawnInventories;

					//--- Exit if the array didn't change
					if (str _respawnInventories == str (missionnamespace getvariable ["BIS_fnc_respawnMenuPosition_inventories",[]])) exitwith {};
					BIS_fnc_respawnMenuPosition_inventories = _respawnInventories;

					if (count _respawnInventories > 0) then {
						lbclear _ctrlList;
						if (count _respawnInventories > 1) then {
							_lbAdd = _ctrlList lbAdd format ["<%1>",localize "STR_A3_BIS_fnc_respawnMenuInventory_random"];
							_ctrlList lbsetdata [_lbAdd,""];
						};

						_cursel = 0;
						{
							_cfg = missionconfigfile >> "cfgrespawninventory" >> _x;
							if (isclass _cfg) then {
								_varName = "BIS_fnc_respawnMenuInventory_" + _x;
								_var = missionnamespace getvariable _varName;
								if (isnil {_var}) then {

									//--- Create loadout preview
									_displayName = gettext (_cfg >> "displayName");
									_icon = gettext (_cfg >> "icon");

									//--- Get CfgVehicles class
									_vehicle = gettext (_cfg >> "vehicle");
									if (_vehicle != "") then {
										_cfg = configfile >> "cfgvehicles" >> _vehicle;
										if (_displayName == "") then {_displayName = _cfg call bis_fnc_displayName;};
										if (_icon == "") then {_icon = gettext (_cfg >> "icon");};
									};

									//--- Load icon
									_icon = _icon call bis_fnc_textureVehicleIcon;
									if (_icon == "") then {_icon = "#(argb,8,8,3)color(0,0,0,0)";};


									//--- Parse description
									_cfgWeapons = configfile >> "CfgWeapons";
									_cfgMagazines = configfile >> "CfgMagazines";
									_cfgVehicles = configfile >> "CfgVehicles";
									_cfgGoggles = configfile >> "CfgGoggles";
									_itemData = {
										_itemCfg = _this select 0;
										_itemCount = _this select 1;

										if (isclass _itemCfg) then {
											_itemName = _itemCfg call bis_fnc_displayName;
											_picture = gettext (_itemCfg >> "picture");
											_text = _text + format [
												"<img image='%1' size='3' shadow='0' /> %2<t align='right'>%3</t><br />",
												_picture,
												_itemName,
												_itemCount
											];
										};
									};
									_drawCategory = {
										_text = _text + "<br /><br />";
									};
									_weaponData = {
										_cfgWeapon = _cfgWeapons >> (_this select 0);
										if (isclass _cfgWeapon) then {
											[_cfgWeapon,1] call _itemData;
											{
												[_cfgWeapons >> _x,1] call _itemData;
											} foreach (_this select 1);
											{
												_magazineID = _magazineTypes find (tolower _x);
												if (_magazineID >= 0) then {
													[_cfgMagazines >> _x,_magazineCounts select _magazineID] call _itemData;
													_magazineTypes set [_magazineID,""];
												};
											} foreach getarray (_cfgWeapon >> "magazines");
											[] call _drawCategory;
										};
									};
									_filterArray = {
										_input = _this select 0;
										_outputTypes = _this select 1;
										_outputCounts = _this select 2;

										while {count _input > 0} do {
											_item = _input select 0;
											_outputTypes set [count _outputTypes,tolower _item];
											_outputCounts set [count _outputCounts,{_item == _x} count _input];
											_input = _input - [_item];
										};
										_input
									};

									_text = "";

									_previewObject = (typeof player) createvehiclelocal [10,10,10];
									[_previewObject,_cfg] call bis_fnc_loadInventory;

									_magazines = getarray (_cfg >> "magazines");
									_magazineTypes = [];
									_magazineCounts = [];
									[_magazines,_magazineTypes,_magazineCounts] call _filterArray;

									[primaryweapon _previewObject,primaryweaponitems _previewObject] call _weaponData;
									[secondaryweapon _previewObject,secondaryweaponitems _previewObject] call _weaponData;
									[handgunweapon _previewObject,handgunitems _previewObject] call _weaponData;
									{
										[_cfgMagazines >> _x,_magazineCounts select _foreachindex] call _itemData;
									} foreach _magazineTypes;
									[] call _drawCategory;

									[_cfgWeapons >> uniform _previewObject,1] call _itemData;
									[_cfgWeapons >> vest _previewObject,1] call _itemData;
									[_cfgVehicles >> backpack _previewObject,1] call _itemData;
									[_cfgWeapons >> headgear _previewObject,1] call _itemData;
									[_cfgGoggles >> goggles _previewObject,1] call _itemData;
									[] call _drawCategory;

									_assignedItems = assignedItems _previewObject;
									_assignedItems = _assignedItems - [headgear _previewObject,goggles _previewObject];
									_assignedItemsTypes = [];
									_assignedItemsCounts = [];
									[_assignedItems,_assignedItemsTypes,_assignedItemsCounts] call _filterArray;
									{
										[_cfgWeapons >> _x,_assignedItemsCounts select _foreachindex] call _itemData;
									} foreach _assignedItemsTypes;

									_items = items _previewObject;
									_items = _items - _magazines;
									_itemsTypes = [];

									_itemsCounts = [];
									[_items,_itemsTypes,_itemsCounts] call _filterArray;
									{
										[_cfgWeapons >> _x,_itemsCounts select _foreachindex] call _itemData;
									} foreach _itemsTypes;

									_var = [_displayName,_icon,parsetext _text];
									missionnamespace setvariable [_varName,_var];
								};

								_displayName = _var select 0;
								_icon = _var select 1;

								_lbAdd = _ctrlList lbadd _displayName;
								_ctrlList lbsetpicture [_lbAdd,_icon];
								_ctrlList lbsetdata [_lbAdd,_x];

								if (_x == _selected) then {_cursel = _lbAdd;};
							};
						} foreach _respawnInventories;

						if (_cursel != lbcursel _ctrlList) then {
							BIS_fnc_respawnMenuInventory_selected = "";
							_ctrlList lbsetcursel _cursel;
						};
					} else {
						["No respawn inventories found"] call bis_fnc_error;
					};
				};
			};
		}
	] call bis_fnc_showRespawnMenu;

} else {
	///////////////////////////////////////////////////////////////////////////////////////////
	//--- onPlayerRespawn
	///////////////////////////////////////////////////////////////////////////////////////////

	//--- Player - assign selected inventory
	_selected = if (isplayer _unit) then {missionnamespace getvariable ["BIS_fnc_respawnMenuInventory_selected",""]} else {""};
	if (_selected == "") then {
		_respawnInventories = (_unit call bis_fnc_getRespawnInventories);
		_selected = if (count _respawnInventories > 0) then {
			_respawnInventories call bis_fnc_selectrandom
		} else {
			["No respawn inventories found"] call bis_fnc_error;
			""
		};
	};

	_cfg = missionconfigfile >> "cfgrespawninventory" >> _selected;
	if (isclass _cfg) then {
		_vehicle = gettext (_cfg >> "vehicle");
		if (_vehicle != "") then {_cfg = _vehicle;};
		[_unit,_cfg] call bis_fnc_loadInventory;
		if (vehicle _unit == _unit) then {_unit switchmove "";};
		_unit setVariable ["role", _selected, true];
	};

	//--- Reset the respawn delay
	if (isplayer _unit) then {
		setplayerrespawntime _respawnDelay;
	};
};