class none
{
	displayName = "Rifleman";
	vehicle = "B_Soldier_F";
	role = "none";
	show = "true";
	items[] = {};
};

class medic
{
	displayName = "Medic";
	vehicle = "B_medic_F";
	role = "medic";
	show = "({ (_x getVariable [""role"", ""none""]) == ""medic"" } count playableUnits) < 10";
	items[] = { /* these guys get medic bag, of course */ };
};

class sniper
{
	displayName = "Marksman";
	vehicle = "B_sniper_F";
	role = "sniper";
	show = "({ (_x getVariable [""role"", ""none""]) == ""sniper"" } count playableUnits) < 5";
	items[] = { /* all snipers */ };
};

class aa
{
	displayName = "AA Specialist";
	vehicle = "B_soldier_AA_F";
	role = "aa";
	show = "({ (_x getVariable [""role"", ""none""]) == ""aa"" } count playableUnits) < 5";
	items[] = { /* all AA weapons */ };
};

class at
{
	displayName = "AT Specialist";
	vehicle = "B_soldier_AT_F";
	role = "at";
	show = "({ (_x getVariable [""role"", ""none""]) == ""at"" } count playableUnits) < 10";
	items[] = { /* all AT weapons */ };
};

class engineer
{
	displayName = "Engineer";
	vehicle = "B_engineer_F";
	role = "engineer";
	show = "({ (_x getVariable [""role"", ""none""]) == ""engineer"" } count playableUnits) < 10";
	items[] = { /* these fellas get the engineer backpack */ };
};

class grenadier
{
	displayName = "Grenadier";
	vehicle = "B_Soldier_GL_F";
	role = "grenadier";
	show = "({ (_x getVariable [""role"", ""none""]) == ""grenadier"" } count playableUnits) < 10";
	items[] = { /* GLs etc */ };
};

class autorifleman
{
	displayName = "Automatic Rifleman";
	vehicle = "B_soldier_AR_F";
	role = "autorifleman";
	show = "({ (_x getVariable [""role"", ""none""]) == ""autorifleman"" } count playableUnits) < 10";
	items[] = { /* Access to all LMGs! */ };
};

class ammo
{
	displayName = "Ammo Bearer";
	vehicle = "B_Soldier_A_F";
	role = "ammo";
	show = "({ (_x getVariable [""role"", ""none""]) == ""ammo"" } count playableUnits) < 5";
	items[] = { /* give ammo guys access to the massive backpack */ };
};

class uav
{
	displayName = "UAV Operator";
	vehicle = "B_soldier_UAV_F";
	role = "uav";
	show = "({ (_x getVariable [""role"", ""none""]) == ""uav"" } count playableUnits) < 2";
	items[] = { /* Access to UAV backpack */ };
};

class pilot
{
	displayName = "Pilot";
	vehicle = "B_pilot_F";
	role = "pilot";
	show = "({ (_x getVariable [""role"", ""none""]) == ""pilot"" } count playableUnits) < 4";
	items[] = {};
}