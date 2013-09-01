class init
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
		text = "Tactical Mission:";
	};
};

class update
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
		text = "Tactical Update:";
	};
};