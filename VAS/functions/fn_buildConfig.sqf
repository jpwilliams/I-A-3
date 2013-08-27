/*
	@version: 1.0
	@file_name: build_config.sqf
	@file_author: TAW_Tonic
	@file_edit: 5/9/2013
	@file_description: If preload is enabled, it will build our preloaded config, otherwise fetches everything from the config.
*/
private["_cfg","_type","_temp","_ret","_master","_class","_details","_displayName","_scope","_type","_str","_itemInfo"];
_cfg = _this select 0;

if(VAS_preload) then
{
	if(!isNil {VAS_pre_weapons} && !isNil {VAS_pre_magazines} && !isNil {VAS_pre_items} && !isNil {VAS_pre_backpacks} && !isNil {VAS_pre_glasses}) exitWith {}; //Exit since preload is completed and shouldn't be called again.
	//If it is called again then why is that? Are you not happy with what I supplied you? I supplied you with wonderful candy! Y U NO LIKE MY CANDY?!?!?
};

switch(_cfg) do
{
	case "CfgWeapons":
	{
		_temp = [];
		_ret = [];
		_ret2 = [];
		_master = configFile >> _cfg;
		private["_base","_ret2"];
		for "_i" from 0 to (count _master)-1 do
		{
			_class = _master select _i;
			if(isClass _class) then
			{
				_class = configName _class;
				_details = [_class,_cfg] call VAS_fnc_fetchCfgDetails;
				_displayName = _details select 1;
				_picture = _details select 2;
				_scope = _details select 3;
				_type = _details select 4;
				_base = configName(inheritsFrom (configFile >> "CfgWeapons" >> _class));
				//diag_log format["DEBUG - %1 :: %2",_class,_base];
				if(_scope >= 2 && _type in [1,2,4,5,4096,131072] && _picture != "" && !(_displayName in _temp) && _displayName != "") then
				{
					_str = [_class,4] call KRON_StrLeft;
					if(_type in [131072,4096] && (_details select 5) != -1) then
					{
						if(_str != "ACRE" && !(_class in VAS_r_items)) then
						{
							_temp set[count _temp,_displayName];
							_ret2 set[count _ret2,_class];
						};
					}
						else
					{
					
						if(_str != "ACRE" && !(_base in VAS_r_weapons) && !(_class in VAS_r_weapons)) then
						{
							_temp set[count _temp,_displayName];
							_ret set[count _ret,_class];
						};
					};
				};
			};
		};
		
		VAS_pre_weapons = _ret;
		VAS_pre_items = _ret2;
	};
	
	case "CfgMagazines":
	{
		_temp = [];
		_ret = [];
		_master = configFile >> _cfg;
		for "_i" from 0 to (count _master)-1 do
		{
			_class = _master select _i;
			if(isClass _class) then
			{
				_class = configName _class;
				_details = [_class,_cfg] call VAS_fnc_fetchCfgDetails;
				_displayName = _details select 1;
				_picture = _details select 2;
				_scope = _details select 3;
				
				if(_scope >= 1 && _picture != "" && !(_displayName in _temp)) then
				{
					_str = [_class,4] call KRON_StrLeft;
					if(_str != "ACRE" && !(_class in VAS_R_magazines)) then
					{
						_temp set[count _temp,_displayName];
						_ret set[count _ret,_class];
					};
				};
			};
		};
		
		VAS_pre_magazines = _ret;
	};
	
	case "CfgVehicles":
	{
		_ret = [];
		_master = configFile >> _cfg;
		private["_base"];
		for "_i" from 0 to (count _master)-1 do
		{
			_class = _master select _i;
			if(isClass _class) then
			{
				_class = configName _class;
				_details = [_class,_cfg] call VAS_fnc_fetchCfgDetails;
				_displayName = _details select 1;
				_picture = _details select 2;
				_scope = _details select 3;
				_type = _details select 4;
				_base = inheritsFrom (configFile >> _cfg >> _class);
				if(_scope >= 2 && _type == "Backpacks" && _picture != "") then
				{
					_str = [_class,4] call KRON_StrLeft;
					if(_str != "ACRE" && !(_base in VAS_r_backpacks) && !(_class in VAS_r_backpacks)) then
					{
						_ret set[count _ret,_class];
					};
				};
			};
		};
		
		VAS_pre_backpacks = _ret;
	};
	
	case "CfgGlasses":
	{
		_temp = [];
		_ret = [];
		_master = configFile >> _cfg;
		for "_i" from 0 to (count _master)-1 do
		{
			_class = _master select _i;
			if(isClass _class) then
			{
				_class = configName _class;
				_details = [_class,_cfg] call VAS_fnc_fetchCfgDetails;
				_displayName = _details select 1;
				_picture = _details select 2;
				
				if(_picture != "" && _displayName != "None" && !(_displayName in _temp)) then
				{
					_str = [_class,4] call KRON_StrLeft;
					if(_str != "ACRE" && !(_class in VAS_r_glasses)) then
					{
						_temp set[count _temp,_displayName];
						_ret set[count _ret,_class];
					};
				};
			};
		};
		VAS_pre_glasses = _ret;
	};
};