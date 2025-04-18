::AR.TooltipHandler <-
{
	function createTooltipEntries()
	{
		local entries = [];
		local push = @(_entry) ::AR.Standard.push(_entry, entries);

		if (::AR.Standard.getParameter("VerboseTooltip"))
		{
			push(this.createCharmResistEntry());
			push(this.createSleepResistEntry());
		}

		push(this.createTutorialEntry());
		return entries;
	}

	function createCharmResistEntry()
	{
		local chance = ::AR.Standard.getParameter("CharmResistChance");
		return ::AR.Standard.constructEntry
		(
			"Special",
			format(::AR.Utilities.getString("CharmResistChanceTooltip"), ::AR.Standard.colourWrap(chance, ::AR.Standard.Colour.Green))
		);
	}

	function createSleepResistEntry()
	{
		local chance = ::AR.Standard.getParameter("SleepResistChance");
		return ::AR.Standard.constructEntry
		(
			"Special",
			format(::AR.Utilities.getString("SleepResistChanceTooltip"), ::AR.Standard.colourWrap(chance, ::AR.Standard.Colour.Green))
		);
	}

	function createTutorialEntry()
	{
		local sizeDifference = ::AR.Standard.getParameter("RosterMax") - ::AR.Utilities.getCurrentRosterSize();
		local tooltipText = format(::AR.Utilities.getString("RosterThresholdTooltip"), ::AR.Standard.colourWrap(sizeDifference, ::AR.Standard.Colour.Red));
		local icon = "Positive";

		if (sizeDifference == 1)
		{
			icon = "Warning";
			tooltipText = ::AR.Standard.colourWrap(::AR.Utilities.getString("RosterThresholdTooltipSingular"), ::AR.Standard.Colour.Red);
		}

		return ::AR.Standard.constructEntry
		(
			icon,
			tooltipText
		);
	}
};