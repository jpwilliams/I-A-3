class standard
{
	displayName = "Rifleman";
	icon = "\A3\ui_f\data\igui\cfg\mptable\infantry_ca.paa";
	vehicle = "B_Soldier_F";
	show = "true";
	restrictions[] = {};
};

class medic
{
	displayName = "Medic";
	icon = "\A3\ui_f\data\igui\cfg\mptable\infantry_ca.paa";
	vehicle = "B_medic_F";
	show = "({ (_x getVariable [""role"", ""standard""]) == ""medic"" } count playableUnits) < 10";
	restrictions[] = { /* these guys get medic bag, of course */ };
};

class sniper
{
	displayName = "Marksman";
	icon = "\A3\ui_f\data\igui\cfg\weaponicons\srifle_ca.paa";
	vehicle = "B_sniper_F";
	show = "({ (_x getVariable [""role"", ""standard""]) == ""sniper"" } count playableUnits) < 5";
	restrictions[] =
	{
		"U_B_GhillieSuit",
		"U_I_GhillieSuit",
		"U_O_GhillieSuit",
		"srifle_EBR_ACO_F",
		"srifle_EBR_ARCO_pointer_F",
		"srifle_EBR_ARCO_pointer_snds_F",
		"srifle_EBR_F",
		"srifle_EBR_MRCO_pointer_F",
		"srifle_EBR_SOS_F",
		"srifle_GM6_F",
		"srifle_GM6_SOS_F",
		"srifle_LRR_F",
		"srifle_LRR_SOS_F"
	};
};

class aa
{
	displayName = "AA Specialist";
	icon = "\A3\ui_f\data\igui\cfg\weaponicons\AA_ca.paa";
	vehicle = "B_soldier_AA_F";
	show = "({ (_x getVariable [""role"", ""standard""]) == ""aa"" } count playableUnits) < 5";
	restrictions[] =
	{
		"launch_B_Titan_F",
		"launch_I_Titan_F",
		"launch_O_Titan_F",
		"launch_Titan_base",
		"launch_Titan_F"
	};
};

class at
{
	displayName = "AT Specialist";
	icon = "\A3\ui_f\data\igui\cfg\weaponicons\AT_ca.paa";
	vehicle = "B_soldier_AT_F";
	show = "({ (_x getVariable [""role"", ""standard""]) == ""at"" } count playableUnits) < 10";
	restrictions[] =
	{
		"launch_B_Titan_short_F",
		"launch_I_Titan_short_F",
		"launch_NLAW_F",
		"launch_O_Titan_short_F",
		"launch_RPG32_F",
		"launch_Titan_short_base",
		"launch_Titan_short_F"
	};
};

class engineer
{
	displayName = "Engineer";
	icon = "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa";
	vehicle = "B_engineer_F";
	show = "({ (_x getVariable [""role"", ""standard""]) == ""engineer"" } count playableUnits) < 10";
	restrictions[] =
	{
		"ToolKit"
	};
};

class grenadier
{
	displayName = "Grenadier";
	icon = "\A3\ui_f\data\igui\cfg\weaponicons\GL_ca.paa";
	vehicle = "B_Soldier_GL_F";
	show = "({ (_x getVariable [""role"", ""standard""]) == ""grenadier"" } count playableUnits) < 10";
	restrictions[] =
	{
		"arifle_Katiba_GL_ACO_F",
		"arifle_Katiba_GL_ACO_pointer_F",
		"arifle_Katiba_GL_ACO_pointer_snds_F",
		"arifle_Katiba_GL_ARCO_pointer_F",
		"arifle_Katiba_GL_F",
		"arifle_Katiba_GL_Nstalker_pointer_F",
		"arifle_Mk20_GL_ACO_F",
		"arifle_Mk20_GL_F",
		"arifle_Mk20_GL_MRCO_pointer_F",
		"arifle_Mk20_GL_plain_F",
		"arifle_MX_GL_ACO_F",
		"arifle_MX_GL_ACO_pointer_F",
		"arifle_MX_GL_F",
		"arifle_MX_GL_Hamr_pointer_F",
		"arifle_MX_GL_Holo_pointer_snds_F",
		"arifle_TRG21_GL_ACO_pointer_F",
		"arifle_TRG21_GL_F",
		"arifle_TRG21_GL_MRCO_F",
		"GrenadeLauncher",
		"UGL_F"
	};
};

class autorifleman
{
	displayName = "Automatic Rifleman";
	icon = "\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa";
	vehicle = "B_soldier_AR_F";
	show = "({ (_x getVariable [""role"", ""standard""]) == ""autorifleman"" } count playableUnits) < 10";
	restrictions[] =
	{
		"LMG_M200",
		"LMG_Minigun",
		"LMG_Minigun2",
		"LMG_Mk200_F",
		"LMG_Mk200_MRCO_F",
		"LMG_Mk200_pointer_F",
		"LMG_RCWS",
		"LMG_Zafir_F",
		"LMG_Zafir_pointer_F"
	};
};

class ammo
{
	displayName = "Ammo Bearer";
	icon = "\A3\ui_f\data\igui\cfg\actions\reammo_ca.paa";
	vehicle = "B_Soldier_A_F";
	show = "({ (_x getVariable [""role"", ""standard""]) == ""ammo"" } count playableUnits) < 5";
	restrictions[] =
	{
		"V_BandollierB_blk",
		"V_BandollierB_cbr",
		"V_BandollierB_khk",
		"V_BandollierB_oli",
		"V_BandollierB_rgr"
	};
};

class uav
{
	displayName = "UAV Operator";
	icon = "\A3\ui_f\data\gui\cfg\hints\icon_text\b_uav_ca.paa";
	vehicle = "B_soldier_UAV_F";
	show = "({ (_x getVariable [""role"", ""standard""]) == ""uav"" } count playableUnits) < 2";
	restrictions[] =
	{
		"B_UavTerminal",
		"I_UavTerminal",
		"UavTerminal_base"
	};
};

class pilot
{
	displayName = "Pilot";
	icon = "\A3\ui_f\data\gui\cfg\CommunicationMenu\transport_ca.paa";
	vehicle = "B_pilot_F";
	show = "({ (_x getVariable [""role"", ""standard""]) == ""pilot"" } count playableUnits) < 4";
	restrictions[] =
	{
		"H_CrewHelmetHeli_B",
		"H_CrewHelmetHeli_I",
		"H_CrewHelmetHeli_O",
		"H_PilotHelmetFighter_B",
		"H_PilotHelmetFighter_I",
		"H_PilotHelmetFighter_O",
		"H_PilotHelmetHeli_B",
		"H_PilotHelmetHeli_I",
		"H_PilotHelmetHeli_O",
		"U_B_HeliPilotCoveralls",
		"U_B_PilotCoveralls",
		"U_I_HeliPilotCoveralls",
		"U_I_pilotCoveralls",
		"U_O_PilotCoveralls"
	};
};

class explosives
{
	displayName = "Explosives Specialist";
	icon = "\A3\ui_f\data\igui\cfg\cursors\explosive_ca.paa";
	vehicle = "B_soldier_exp_F";
	show = "({ (_x getVariable [""role"", ""standard""]) == ""explosives"" } count playableUnits) < 8";
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