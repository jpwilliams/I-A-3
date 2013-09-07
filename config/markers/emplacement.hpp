class init
{
	class marker
	{
		shape = "ELLIPSE";
		color = "ColorBLUFOR";
		brush = "FDiagonal";
		size[] = {100, 100};
	};

	class icon
	{
		shape = "ICON";
		type = "b_art";
		color = "ColorBLUFOR";
	};
};

class defending
{
	class marker
	{
		shape = "ELLIPSE";
		brush = "BDiagonal";
		size[] = {100, 100};
		color = "ColorOrange";
	};

	class icon
	{
		shape = "ICON";
		type = "b_art";
		color = "ColorOrange";
		text = "(Under Attack)";
	};
};

class ammo
{
	class marker
	{
		shape = "ELLIPSE";
		color = "ColorBLUFOR";
		brush = "FDiagonal";
		size[] = {100, 100};
	};

	class icon
	{
		shape = "ICON";
		type = "mil_warning";
		color = "ColorBLUFOR";
		text = "(Needs Ammo)";
	};
};

class truck
{
	class marker {};
	class icon
	{
		shape = "ICON";
		type = "mil_warning";
		color = "ColorBLUFOR";
		text = "Repair Truck for";
	};
};