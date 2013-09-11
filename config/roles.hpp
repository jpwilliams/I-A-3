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
	restrictions[] =
	{
		"launch_RPG32_F",
		"RPG32_AA_F"
	};
};

class at
{
	displayName = "AT Specialist";
	vehicle = "B_soldier_AT_F";
	show = "({ (_x getVariable [""role"", ""none""]) == ""at"" } count playableUnits) < 10";
	restrictions[] =
	{
		"launch_NLAW_F",
		"launch_RPG32_F"
		"NLAW_F",
		"RPG32_F"
	};
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
	restrictions[] =
	{
		"arifle_Khaybar_GL_ACO_point_F",
		"arifle_Khaybar_GL_ACOg_point_F",
		"arifle_Khaybar_GL_F",
		"arifle_MX_GL_ACO_point_F",
		"arifle_MX_GL_ACOg_point_F",
		"arifle_MX_GL_ARCO_point_F",
		"arifle_MX_GL_F",
		"arifle_MX_GL_Hamr_point_F",
		"arifle_TRG21_GL_ACO_point_F",
		"arifle_TRG21_GL_ACOg_point_F",
		"arifle_TRG21_GL_F",
		"3Rnd_UGL_FlareGreen_F",
		"3Rnd_UGL_FlareCIR_F",
		"3Rnd_UGL_FlareRed_F",
		"3Rnd_UGL_FlareWhite_F",
		"3Rnd_UGL_FlareYellow_F",
		"3Rnd_SmokeBlue_Grenade_shell",
		"3Rnd_SmokeGreen_Grenade_shell",
		"3Rnd_SmokeOrange_Grenade_shell",
		"3Rnd_SmokePurple_Grenade_shell",
		"3Rnd_SmokeRed_Grenade_shell",
		"3Rnd_Smoke_Grenade_shell",
		"3Rnd_SmokeYellow_Grenade_shell",
		"3Rnd_HE_Grenade_shell",
		"1Rnd_HE_Grenade_shell",
		"UGL_FlareGreen_F",
		"UGL_FlareCIR_F",
		"UGL_FlareRed_F",
		"UGL_FlareWhite_F",
		"UGL_FlareYellow_F"
		"1Rnd_SmokeBlue_Grenade_shell",
		"1Rnd_SmokeGreen_Grenade_shell",
		"1Rnd_SmokeOrange_Grenade_shell",
		"1Rnd_SmokePurple_Grenade_shell",
		"1Rnd_SmokeRed_Grenade_shell",
		"1Rnd_Smoke_Grenade_shell",
		"1Rnd_SmokeYellow_Grenade_shell"
	};
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
	restrictions[] =
	{
		"H_PilotHelmetHeli_B",
		"U_B_HeliPilotCoveralls"
	};
};

class explosives
{
	displayName = "Explosives Specialist";
	vehicle = "";
	show = "";
	restrictions[] =
	{
		"MineDetector",
		"APERSBoundingMine_Range_Mag",
		"APERSMine_Range_Mag",
		"APERSTripMine_Wire_Mag",
		"ATMine_Range_Mag",
		"DemoCharge_Remote_Mag",
		"SatchelCharge_Remote_Mag",
		"SLAMDirectionalMine_Wire_Mag",
		"APERSBoundingMine_Range_Ammo",
		"APERSMine_Range_Ammo",
		"APERSTripMine_Wire_Ammo",
		"ATMine_Range_Ammo"
	};
};