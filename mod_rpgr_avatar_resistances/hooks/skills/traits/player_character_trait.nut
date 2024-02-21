local AR = ::RPGR_Avatar_Resistances;
::mods_hookExactClass("skills/traits/player_character_trait", function( _object )
{
	AR.Standard.wrap(_object, "getTooltip", function( _tooltipArray )
	{
		if (!AR.Standard.getSetting("ModifyTooltip"))
		{
			return;
		}

		if (!AR.Resistances.isWithinRosterThreshold())
		{
			return;
		}

		_tooltipArray.extend(AR.Resistances.createTooltipEntries());
		return _tooltipArray;
	}, "overrideReturn");
});