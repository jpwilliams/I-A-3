class none
{
	displayName = "Rifleman";
	vehicle = "B_Soldier_F";
	show = "true";
	restrictions[] = {"arifle_MX_ACO_pointer_F"};
};

class medic
{
	displayName = "Medic";
	vehicle = "B_medic_F";
	show = "({ (_x getVariable [""role"", ""none""]) == ""medic"" } count playableUnits) < 10";
	restrictions[] = { /* these guys get medic bag, of course */ };
};

class sniper
{
	displayName = "Marksman";
	vehicle = "B_sniper_F";
	show = "({ (_x getVariable [""role"", ""none""]) == ""sniper"" } count playableUnits) < 5";
	restrictions[] = {"arifle_MX_ACO_pointer_F" /* all snipers */ };
};

class aa
{
	displayName = "AA Specialist";
	vehicle = "B_soldier_AA_F";
	show = "({ (_x getVariable [""role"", ""none""]) == ""aa"" } count playableUnits) < 5";
	restrictions[] = { /* all AA weapons */ };
};

class at
{
	displayName = "AT Specialist";
	vehicle = "B_soldier_AT_F";
	show = "({ (_x getVariable [""role"", ""none""]) == ""at"" } count playableUnits) < 10";
	restrictions[] = { /* all AT weapons */ };
};

class engineer
{
	displayName = "Engineer";
	vehicle = "B_engineer_F";
	show = "({ (_x getVariable [""role"", ""none""]) == ""engineer"" } count playableUnits) < 10";
	restrictions[] = { /* these fellas get the engineer backpack */ };
};

class grenadier
{
	displayName = "Grenadier";
	vehicle = "B_Soldier_GL_F";
	show = "({ (_x getVariable [""role"", ""none""]) == ""grenadier"" } count playableUnits) < 10";
	restrictions[] = { /* GLs etc */ };
};

class autorifleman
{
	displayName = "Automatic Rifleman";
	vehicle = "B_soldier_AR_F";
	show = "({ (_x getVariable [""role"", ""none""]) == ""autorifleman"" } count playableUnits) < 10";
	restrictions[] = { /* Access to all LMGs! */ };
};

class ammo
{
	displayName = "Ammo Bearer";
	vehicle = "B_Soldier_A_F";
	show = "({ (_x getVariable [""role"", ""none""]) == ""ammo"" } count playableUnits) < 5";
	restrictions[] = { /* give ammo guys access to the massive backpack */ };
};

class uav
{
	displayName = "UAV Operator";
	vehicle = "B_soldier_UAV_F";
	show = "({ (_x getVariable [""role"", ""none""]) == ""uav"" } count playableUnits) < 2";
	restrictions[] = { /* Access to UAV backpack */ };
};

class pilot
{
	displayName = "Pilot";
	vehicle = "B_pilot_F";
	show = "({ (_x getVariable [""role"", ""none""]) == ""pilot"" } count playableUnits) < 4";
	restrictions[] = {};
};

class explosives
{
	displayName = "Explosives Specialist";
	vehicle = "";
	show = "";
	restrictions[] = {};
};