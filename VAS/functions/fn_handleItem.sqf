/*
	@version: 1.3
	@file_name: fn_handleItem.sqf
	@file_author: TAW_Tonic
	@file_edit: 6/22/2013
	@file_description: Handles the incoming requests and adds or removes it, returns true if operation done sucessfully or false for failing.
*/
private["_item","_details","_bool","_ispack","_items","_isgun","_ongun","_override"];
_item = _this select 0;
_bool = _this select 1;
_ispack = if(isNil {_this select 2}) then {false} else {_this select 2};
_ongun = if(isNil {_this select 3}) then {false} else {_this select 3};
_override = if(isNil {_this select 4}) then {false} else {_this select 4};
_gear = str([] call VAS_fnc_fetchPlayerGear);
_isgun = false;

_details = [_item] call VAS_fnc_fetchCfgDetails;
if(count _details == 0) exitWith {};

if(
(_item in VAS_r_weapons) OR (_item in VAS_r_backpacks) OR (_item in VAS_r_magazines) OR (_item in VAS_r_items) OR (_item in VAS_r_glasses) OR
((_details select 13) in VAS_r_weapons) OR ((_details select 13) in VAS_r_backpacks) OR ((_details select 13) in VAS_r_magazines) OR ((_details select 13) in VAS_r_items) OR ((_details select 13) in VAS_r_glasses)
) exitWith {systemChat format["%1 is a restricted item and will be not added.",(_details select 1)];};

if(_bool) then
{
	switch((_details select 6)) do
	{
		case "CfgGlasses":
		{
			if(goggles player != "") then
			{
				removeGoggles player;
			};
			player addGoggles _item;
		};
		
		case "CfgVehicles":
		{
			if(backpack player != "") then
			{
				_items = (backpackItems player);
				removeBackpack player;
			};
			player addBackpack _item;
			if(!isNil {_items}) then 
			{ 
				{[_x,true,true,false,true] spawn VAS_fnc_handleItem; } foreach _items;
			};
		};
		
		case "CfgMagazines":
		{
			if(_ispack) then
			{
				(unitBackpack player) addMagazineCargoGlobal [_item,1];
			}
				else
			{
				player addMagazine _item;
			};
		};
		
		case "CfgWeapons":
		{
			if((_details select 4) in [1,2,4,5,4096]) then
			{
				if((_details select 4) == 4096) then
				{
					if((_details select 5) == -1) then
					{
						_isgun = true;
					};
				}
					else
				{
					_isgun = true;
				};
			};
			
			
			if(_isgun) then
			{
				if(!_ispack && _override) exitWith {}; //It was in the vest/uniform, try to close to prevent it overriding stuff... (Actual weapon and not an item)
				if(_item == "MineDetector") then
				{
					player addItem _item;
				}
					else
				{
					if(_ispack) then
					{
						if(backpack player != "") then {(unitBackpack player) addWeaponCargoGlobal [_item,1];};
					}
						else
					{
						player addWeapon _item;
					};
				};
			}
				else
			{
				switch(_details select 5) do
				{
					case 0: 
					{
						if(_ispack) then
						{
							(unitBackpack player) addItemCargoGlobal [_item,1];
						}
							else
						{
							if(_override) then
							{
								player addItem _item;
							}
								else
							{
								if(_item in (assignedItems  player)) then 
								{
									player addItem _item;
								} 
									else 
								{
									player addItem _item; 
									player assignItem _item;
								};
							};
						};
					};
					case 605: 
					{
						if(_ispack) then
						{
							(unitBackpack player) addItemCargoGlobal [_item,1];
						}
							else
						{
							if(_override) then
							{
								player addItem _item;
							}
								else
							{
								if(headGear player == _item) then
								{
									player addItem _item;
								}
									else
								{
									if(headGear player != "") then
									{
										removeHeadGear player;
									};
									player addHeadGear _item;
								};
							};
						};
					};
					case 801: 
					{
						if(_ispack) then
						{
							(unitBackpack player) addItemCargoGlobal [_item,1];
						}
							else
						{
							if(_override) then
							{
								player addItem _item;
							}
								else
							{
								if(uniform player == _item) then
								{
									player addItem _item;
								}
									else
								{
									if(uniform player != "") then
									{
										_items = uniformItems player;
										removeUniform player;
									};
									
									player addUniform _item;
									
									if(!isNil {_items}) then
									{
										{[_x,true,nil,false,true] spawn VAS_fnc_handleItem;} foreach _items;
									};
								};
							};
						};
					};
					case 701:
					{
						if(_ispack) then 
						{
							(unitBackpack player) addItemCargoGlobal [_item,1];
						}
							else
						{
							if(_override) then
							{
								player addItem _item;
							}
								else
							{
								if(vest player == _item) then
								{
									player addItem _item;
								}
									else
								{
									if(vest player != "") then
									{
										_items = vestItems player;
										removeVest player;
									};
									
									player addVest _item;
									
									if(!isNil {_items}) then
									{
										{[_x,true,nil,false,true] spawn VAS_fnc_handleItem;} foreach _items;
									};
								};
							};
						};
					};
					
					case 201:
					{
						if(_ispack) then
						{
							(unitBackpack player) addItemCargoGlobal [_item,1];
						}
							else
						{
							private["_type"];
							_type = [_item,201] call VAS_fnc_accType;
							if(_ongun) then
							{
								switch (_type) do
								{
									case 1: { player addPrimaryWeaponItem _item; };
									case 2: { player addSecondaryWeaponItem _item; };
									case 3: { player addHandgunItem _item; };
								};
							}
								else
							{
								if(_override) then
								{
									player addItem _item;
								}
									else
								{
									createDialog "VAS_prompt";
									waitUntil {!isNil {vas_prompt_choice}};
									if(vas_prompt_choice) then
									{
										switch (_type) do
										{
											case 1: { player addPrimaryWeaponItem _item; };
											case 2: { player addSecondaryWeaponItem _item; };
											case 3: { player addHandgunItem _item; };
										};
									}
										else
									{
										player addItem _item;
									};
									vas_prompt_choice = nil;
								};
							};
						};
					};
					
					case 301:
					{
						if(_ispack) then
						{
							(unitBackpack player) addItemCargoGlobal [_item,1];
						}
							else
						{
							private["_type"];
							_type = [_item,301] call VAS_fnc_accType;
							
							if(_ongun) then
							{ 
								switch (_type) do
								{
									case 1: { player addPrimaryWeaponItem _item; };
									case 2: { player addSecondaryWeaponItem _item; };
									case 3: { player addHandgunItem _item; };
								};
							}
								else
							{
								if(_override) then
								{
									player addItem _item;
								}
									else
								{
									createDialog "VAS_prompt";
									waitUntil {!isNil {vas_prompt_choice}};
									if(vas_prompt_choice) then
									{
										switch (_type) do
										{
											case 1: { player addPrimaryWeaponItem _item; };
											case 2: { player addSecondaryWeaponItem _item; };
											case 3: { player addHandgunItem _item; };
										};
									}
										else
									{
										player addItem _item;
									};
									vas_prompt_choice = nil;
								};
							};
						};
					};
					
					case 101:
					{
						if(_ispack) then
						{
							(unitBackpack player) addItemCargoGlobal [_item,1];
						}
							else
						{
							private["_type"];
							_type = [_item,101] call VAS_fnc_accType;
							
							if(_ongun) then
							{ 
								switch (_type) do
								{
									case 1: { player addPrimaryWeaponItem _item; };
									case 2: { player addSecondaryWeaponItem _item; };
									case 3: { player addHandgunItem _item; };
								};
							}
								else
							{
								if(_override) then
								{
									player addItem _item;
								}
									else
								{
									createDialog "VAS_prompt";
									waitUntil {!isNil {vas_prompt_choice}};
									if(vas_prompt_choice) then
									{
										switch (_type) do
										{
											case 1: { player addPrimaryWeaponItem _item; };
											case 2: { player addSecondaryWeaponItem _item; };
											case 3: { player addHandgunItem _item; };
										};
									}
										else
									{
										player addItem _item;
									};
									vas_prompt_choice = nil;
								};
							};
						};
					};
					
					default 
					{ 
						if(_ispack) then 
						{
							(unitBackpack player) addItemCargoGlobal [_item,1];
						} 
							else 
						{
							if(_item == "NVGoggles") then
							{
								player addItem _item;
								player assignItem _item;
							}
								else
							{
								player addItem _item;
							};
						};
					};
				};
			};
		};
	};
}
	else
{
	switch((_details select 6)) do
	{
		case "CfgVehicles":
		{
			removeBackpack player;
		};
		
		case "CfgMagazines":
		{
			player removeMagazine _item;
		};
		
		case "CfgGlasses":
		{
			removeGoggles player;
		};
		
		case "CfgWeapons":
		{
			if((_details select 4) in [1,2,4,5,4096]) then
			{
				if((_details select 4) == 4096) then
				{
					if(isNil {(_details select 5)}) then
					{
						_isgun = true;
					};
				}
					else
				{
					_isgun = true;
				};
			};
			
			if(_isgun) then
			{
				switch(true) do
				{
					case (primaryWeapon player == _item) : {_ispack = false;};
					case (secondaryWeapon player == _item) : {_ispack = false;};
					case (handGunweapon player == _item) : {_ispack = false;};
					case (_item in assignedItems player) : {_ispack = false;};
					default {_ispack = true;};
				};
				
				if(_item == "MineDetector") then
				{
					player removeItem _item;
				}
					else
				{
					if(_ispack) then
					{
						_items = (backpackItems player);
						_index = _items find _item;
						if(_index != -1) then
						{
							_items set[_index,-1];
							_items = _items - [-1];
						};
						clearWeaponCargo (unitBackpack player);
						if(count _items > 0) then
						{
							{[_x,true,true,nil,nil] spawn VAS_fnc_handleItem;} foreach _items;
						};
					}
						else
					{
						player removeWeapon _item;
					};
				};
			}
				else
			{
				switch((_details select 5)) do
				{
					case 0: {player unassignItem _item; player removeItem _item;};
					case 605: {if(headGear player == _item) then {removeHeadgear player} else {player removeItem _item};};
					case 801: {if(uniform player == _item) then {removeUniform player} else {player removeItem _item};};
					case 701: {if(vest player == _item) then {removeVest player} else {player removeItem _item};};
					default 
					{
						switch (true) do
						{
							case (_item in (primaryWeaponItems player)) : {player removePrimaryWeaponItem _item;};
							case (_item in (handgunItems player)) : {player removeHandgunItem _item;};
							case (_item == "NVGoggles") : {player unassignItem _item; player removeItem _item;};
							default {player removeItem _item;};
						};
					};
				};
			};
		};
	};
};