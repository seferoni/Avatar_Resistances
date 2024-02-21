local AR = ::RPGR_Avatar_Resistances;
AR.Resistances <-
{
	Tooltip = 
	{
		Icons = 
		{
			Special = "ui/icons/perks.png",
			Warning = "ui/icons/warning.png"
		},
		Template = 
		{
			id = 10, 
			type = "text", 
			icon = "", 
			text = ""
		}
	}

	function createTooltipEntries()
	{
		local entries = [],
		push = @(_entry) entries.push(_entry),
		generate = @(_skill) format("%s%% chance to resist %s", AR.Standard.colourWrap(AR.Standard.getSetting(format("%sResistChance", _skill)), AR.Standard.Colour.Green), _skill);

		local charmResistEntry = clone this.Tooltip.Template;
		charmResistEntry.icon = this.Tooltip.Icons.Special;
		charmResistEntry.text = generate("Charm");
		push(charmResistEntry);

		local sleepResistEntry = clone charmResistEntry;
		sleepResistEntry.text = generate("Sleep");
		push(sleepResistEntry);

		local warningEntry = clone this.Tooltip.Template;
		warningEntry.icon = this.Tooltip.Icons.Warning;
		warningEntry.text = format("Loses resistances when the company grows above %s men", AR.Standard.colourWrap(AR.Standard.getSetting("RosterMax"), "NegativeValue"));
		push(warningEntry);

		return entries;
	}

	function isActorViable( _actor )
	{
		return AR.Standard.getFlag("IsPlayerCharacter", _actor);
	}

	function isWithinRosterThreshold()
	{
		return ::World.getPlayerRoster().getAll().len() <= AR.Standard.getSetting("RosterMax");
	}
}