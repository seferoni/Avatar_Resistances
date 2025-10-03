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
		local rosterDifferential = ::AR.Standard.getParameter("RosterThreshold") - ::AR.Utilities.getCurrentRosterSize();
		local tooltipText = format(::AR.Utilities.getString("RosterThresholdTooltip"), ::AR.Standard.colourWrap(rosterDifferential + 1, ::AR.Standard.Colour.Red));

		if (rosterDifferential == 0)
		{
			tooltipText = ::AR.Standard.colourWrap(::AR.Utilities.getString("RosterThresholdTooltipBaseline"), ::AR.Standard.Colour.Red);
		}

		return ::AR.Standard.constructEntry
		(
			"Warning",
			tooltipText
		);
	}
};