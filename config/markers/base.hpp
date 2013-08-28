/***********************************************************\
	All root classes must begin with "base_"
\***********************************************************/

class base_init
{
	class marker {};
	class icon {};
};

class base_friendly
{
	class marker
	{
		color = "ColorBLUFOR"
	};

	class icon
	{
		shape = "ICON";
		type = "b_unknown";
		color = "ColorBLUFOR";
	};
};

class base_contested
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
		text = "(Under Attack)";
	};
};

class base_enemy
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
}