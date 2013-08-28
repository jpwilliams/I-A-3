/***********************************************************\
	All root classes must begin with "tactical_"
\***********************************************************/

class tactical_init
{
	class marker
	{
		shape = "ELLIPSE";
		brush = "Border";
		color = "ColorOPFOR";
		size[] = {300, 300};
	};

	class icon
	{
		shape = "ICON";
		type = "mil_dot";
		color = "ColorOPFOR";
	};
};

class tactical_update
{
	class marker
	{
		shape = "ELLIPSE";
		brush = "BDiagonal";
		color = "ColorOPFOR";
		size[] = {50, 50};
	};

	class icon
	{
		shape = "ICON";
		type = "selector_selectedEnemy";
		color = "ColorOPFOR";
	};
};