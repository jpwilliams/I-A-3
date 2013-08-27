disableserialization;

_unit = [_this,0,objnull,[objnull]] call bis_fnc_param;
_respawnDelay = [_this,3,0,[0]] call bis_fnc_param;

if (!alive _unit) then {
	if (playerrespawntime < 1 || !isplayer _unit) exitwith {};
	setplayerrespawntime (playerrespawntime + 3);

	sleep 2;
	cutText ["","black out",0.5];
	sleep 1;
	cutText ["","black in"];


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

					_subClasses = missionnamespace getvariable ["BIS_fnc_respawnSelectIventory_subClasses",(missionconfigfile >> "CfgRespawnInventory") call bis_fnc_subClasses];
					if (count _subClasses == 0) exitwith {"No classes found in CfgRespawnInventory" call bis_fnc_error;};

					_texts = missionnamespace getvariable ["BIS_fnc_respawnSelectIventory_texts",[]];
					_texts resize (count _subClasses);
					_selected = missionnamespace getvariable ["BIS_fnc_respawnMenuInventory_index",0];

					lbclear _ctrlList;

					_cursel = 0;
					_previewObject = (typeof player) createvehiclelocal [10,10,10];

					_cfgWeapons = configfile >> "CfgWeapons";
					_cfgMagazines = configfile >> "CfgMagazines";
					_cfgVehicles = configfile >> "CfgVehicles";
					_cfgGoggles = configfile >> "CfgGoggles";
					_itemData = {
						_itemCfg = _this select 0;
						_itemCount = _this select 1;

						if (isclass _itemCfg) then {
							_displayName = _itemCfg call bis_fnc_displayName;
							_picture = gettext (_itemCfg >> "picture");
							_text = _text + format [
								"<img image='%1' size='3' shadow='0' /> %2<t align='right'>%3</t><br />",
								_picture,
								_displayName,
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

					{
						_cfg = _x;
						_show = gettext (_cfg >> "show");
						if (_show == "") then {_show = "true";};

						_vehicle = gettext (_cfg >> "vehicle");
						if (_vehicle != "") then {_cfg = configfile >> "cfgvehicles" >> _vehicle};

						_displayName = _cfg call bis_fnc_displayName;
						_icon = gettext (_cfg >> "icon");
						_icon = _icon call bis_fnc_textureVehicleIcon;
						if (_icon == "") then {_icon = "#(argb,8,8,3)color(0,0,0,0)";};
						_showResult = call compile format["%1", _show];

						_text = "";
						if (_showResult) then {
							_index = _foreachindex;
							_color = [1,1,1,1];

							_lbAdd = _ctrlList lbadd _displayName;
							_ctrlList lbsetvalue [_lbAdd,_index];
							_ctrlList lbsetpicture [_lbAdd,_icon];

							if (_index == _selected) then {_cursel = _lbAdd;};

							//--- Parse info
							if (isnil {_texts select _foreachindex}) then {

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
		
								_texts set [_foreachindex,parsetext _text];
							};
						};

					} foreach _subClasses;
					switch (lbsize _ctrlList) do {
						//--- No items available - show error
						case 1: {
							lbclear _ctrlList;
							"No CfgRespawnInventory classes met the 'show' condition." call bis_fnc_error;
							_ctrlList lbsetcursel -1;
						};
						//--- Only one item available - remove ranom option
						case 2: {
							_ctrlList lbdelete 0;
							_ctrlList lbsetcursel (_cursel - 1);
						};
						default {
							_ctrlList lbsetcursel _cursel;
						};
					};

					deletevehicle _previewObject;

					BIS_fnc_respawnSelectIventory_subClasses = _subClasses;
					BIS_fnc_respawnSelectIventory_texts = _texts;
				};
				case "select": {

					_index = _ctrlList lbvalue lbcursel _ctrlList;
					if (_index < 0) then {
						_text = "<t size='3' shadow='0' color='#33ffffff'> ? </t>???<t align='right'>?</t><br />";
						_ctrlContent ctrlsetstructuredtext parsetext (_text + _text + _text + _text + _text);
						_ctrlContent call bis_fnc_ctrlFitToTextHeight;
					} else {
						_text = BIS_fnc_respawnSelectIventory_texts select _index;
						_ctrlContent ctrlsetstructuredtext _text;
						_ctrlContent call bis_fnc_ctrlFitToTextHeight;
					};

					BIS_fnc_respawnMenuInventory_index = _index;
				};
				case "update": {
				};
			};
		}
	] call bis_fnc_showRespawnMenu;

} else {
	///////////////////////////////////////////////////////////////////////////////////////////
	//--- onPlayerRespawn
	///////////////////////////////////////////////////////////////////////////////////////////

	//--- Player - assign selected inventory
	_index = missionnamespace getvariable ["BIS_fnc_respawnMenuInventory_index",-1];

	if (isplayer _unit && _index >= 0) then {
		_subClasses = missionnamespace getvariable ["BIS_fnc_respawnSelectIventory_subClasses",(missionconfigfile >> "CfgRespawnInventory") call bis_fnc_subClasses];
		if (_index < count _subClasses) then {
			_class = _subClasses select _index;
			_vehicle = gettext (_class >> "vehicle");
			_role = gettext (_class >> "role");
			_unit setVariable ["role", _role, true];
			if (_vehicle != "") then {_class = _vehicle;};
			[_unit,_class] call bis_fnc_loadInventory;
			if (vehicle _unit == _unit) then {_unit switchmove "";};
		};

		[] call bis_fnc_showRespawnMenu;
	} else {

		//--- AI - assign random inventory
		_available = [];
		{

			_cfg = _x;
			_show = gettext (_cfg >> "show");
			if (_show == "") then {_show = "true";};
			_showResult = [_unit call compile _show,0,true,[true]] call bis_fnc_paramin;
			if (_showResult) then {_available set [count _available,_cfg];};
		} foreach ((missionconfigfile >> "CfgRespawnInventory") call bis_fnc_subClasses);

		if (count _available > 0) then {
			_class = _available call bis_fnc_selectrandom;
			[_unit,_class] call bis_fnc_loadInventory;
			if (vehicle _unit == _unit) then {_unit switchmove "";};
		};
	};

	//--- Reset the respawn delay
	if (isplayer _unit) then {setplayerrespawntime _respawnDelay;};
};