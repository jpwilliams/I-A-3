_class = (missionConfigFile >> "AW_radio");
_lastIndex = ((count _class) - 1);

if (!isServer) then
{
	while { true } do
	{
		waitUntil { alive player };

		{
			_canShow = call compile format["%1", (_x select 1)];

			if (_canShow) then
			{
				(_x select 0) radioChannelAdd [player];
			};
		} foreach radioChannels;

		while { alive player } do { sleep 2; };
	};
}
else
{
	radioChannels = [];

	for "_i" from 0 to _lastIndex do
	{
		_radio = _class select _i;

		_ret = radioChannelCreate
		[
			getArray (_radio >> "colour"),
			getText (_radio >> "name"),
			getText (_radio >> "prefix"),
			[]
		];

		radioChannels = radioChannels + [[_ret, getText (_radio >> "condition")]];
	};

	publicVariable "radioChannels";
};

if (!isServer) then
{
	"Function ended unexpectedly! Report this to an administrator!" call BIS_fnc_log;
};