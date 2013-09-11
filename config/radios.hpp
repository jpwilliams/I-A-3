class main
{
	colour[] = {1, 0.81, 0.06, 1};
	name = "Main AO Channel";
	prefix = "[MAIN] %UNIT_GRP_NAME %UNIT_NAME [%UNIT_VEH_NAME]";
	condition = "true";
};

class priority
{
	colour[] = {0, 0.47, 0.72, 1};
	name = "Priority Target Channel";
	prefix = "[PRIORITY] %UNIT_GRP_NAME %UNIT_NAME [%UNIT_VEH_NAME]";
	condition = "true";
};

class tactical
{
	colour[] = {0, 0.7, 0.93, 1};
	name = "Tactical Mission Channel";
	prefix = "[TACTICAL] %UNIT_GRP_NAME %UNIT_NAME [%UNIT_VEH_NAME]";
	condition = "true";
};

class ghost
{
	colour[] = {0.8, 0.8, 0.8, 1};
	name = "Ghost Mission Channel";
	prefix = "[GHOST] %UNIT_GRP_NAME %UNIT_NAME [%UNIT_VEH_NAME]";
	condition = "true";
};

class transport
{
	colour[] = {0.38, 0.81, 0.16, 1};
	name = "Transport Request / Chatter";
	prefix = "[TRANSPORT] %UNIT_GRP_NAME %UNIT_NAME [%UNIT_VEH_NAME]";
	condition = "true";
};

class support
{
	colour[] = {0.17, 0.50, 0.82, 1};
	name = "Support Request / Chatter";
	prefix = "[SUPPORT] %UNIT_GRP_NAME %UNIT_NAME [%UNIT_VEH_NAME]";
	condition = "true";
};