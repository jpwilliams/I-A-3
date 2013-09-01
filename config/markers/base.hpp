class init
{
	class marker {};
	class icon {};
};

class friendly
{
	class marker
	{
		color = "ColorBLUFOR";
	};

	class icon
	{
		shape = "ICON";
		type = "b_unknown";
		color = "ColorBLUFOR";
	};
};

class contested
{
	class marker
	{
		color = "ColorUnknown";
	};

	class icon
	{
		shape = "ICON";
		type = "n_unknown";
		color = "ColorOrange";
		text[] = {"(Under Attack)", ""};
	};
};

class enemy
{
	class marker
	{
		color = "ColorOPFOR";
	};

	class icon
	{
		shape = "ICON";
		type = "o_unknown";
		color = "ColorOPFOR";
	};
};