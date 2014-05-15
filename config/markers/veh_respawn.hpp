class init
{
	class marker {};
	class icon {};
};

class at_base
{
	class marker {};

	class icon
	{
		size[] = {0.6, 0.6};
		shape = "ICON";
		type = "b_unknown";
		color = "ColorGreen";
		text[] = {"", "- at base"};
	};
};

class in_action
{
	class marker {};

	class icon
	{
		size[] = {0.6, 0.6};
		shape = "ICON";
		type = "b_unknown";
		color = "ColorYellow";
		text[] = {"", "- in action"};
	};
};

class destroyed
{
	class marker {};

	class icon
	{
		size[] = {0.6, 0.6};
		shape = "ICON";
		type = "b_unknown";
		color = "ColorGrey";
		text[] = {"", "- destroyed"};
	};
};