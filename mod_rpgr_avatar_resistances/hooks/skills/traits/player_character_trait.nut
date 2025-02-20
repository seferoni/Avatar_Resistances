::AR.Patcher.hook("scripts/skills/traits/player_character_trait", function( p )
{
	::AR.Patcher.wrap(p, "getTooltip", function( _tooltipArray )
	{
		if (!::AR.Standard.getParameter("ModifyTooltip"))
		{
			return;
		}

		if (!::AR.Resistances.isWithinRosterThreshold())
		{
			return;
		}

		_tooltipArray.extend(::AR.Resistances.createTooltipEntries());
		return _tooltipArray;
	});
});