::AR.TooltipHandler <-
{
	function createTooltipEntries()
	{
		local entries = [];
		local push = @(_entry) ::AR.Standard.push(_entry, entries);

		push(this.createCharmResistEntry());
		push(this.createSleepResistEntry());
		push(this.createTutorialEntry());
		return entries;
	}

	function createCharmResistEntry()
	{
		local chance = ::AR.Standard.getParameter("CharmResistChance");
		return ::AR.Standard.constructEntry
		(
			"Special",
			format(::AR.Utilities.getStringField("CharmResistChanceTooltip"), ::AR.Standard.colourWrap(chance, ::AR.Standard.Colour.Green))
		);
	}

	function createSleepResistEntry()
	{
		local chance = ::AR.Standard.getParameter("SleepResistChance");
		return ::AR.Standard.constructEntry
		(
			"Special",
			format(::AR.Utilities.getStringField("SleepResistChanceTooltip"), ::AR.Standard.colourWrap(chance, ::AR.Standard.Colour.Green))
		);
	}

	function createTutorialEntry()
	{
		local threshold = ::AR.Standard.getParameter("RosterMax");
		return ::AR.Standard.constructEntry
		(
			"Warning",
			format(::AR.Utilities.getStringField("RosterThresholdTooltip"), ::AR.Standard.colourWrap(threshold, ::AR.Standard.Colour.Red))
		)
	}
};