::RPGR_Avatar_Resistances <-
{
	ID = "mod_rpgr_avatar_resistances",
	Name = "RPG Rebalance - Avatar Resistances",
	Version = "1.5.1",
	Internal =
	{
		TERMINATE = "__end"
	},
	Defaults =
	{
		CharmResistChance = 100,
		SleepResistChance = 60,
		RosterMax = 6,
		ModifyTooltip = true,
		VerboseLogging = true
	}
};

local AR = ::RPGR_Avatar_Resistances;
AR.Internal.MSUFound <- "MSU" in ::getroottable();
::include("mod_rpgr_avatar_resistances/libraries/standard_library.nut");

if (!AR.Internal.MSUFound)
{
	AR.Version = AR.Standard.parseSemVer(AR.Version);
}

::mods_registerMod(AR.ID, AR.Version, AR.Name);
::mods_queue(AR.ID, ">mod_msu", function()
{
	if (!AR.Internal.MSUFound)
	{
		return;
	}

	AR.Mod <- ::MSU.Class.Mod(AR.ID, AR.Version, AR.Name);
	local Defaults = AR.Defaults;

	local pageGeneral = AR.Mod.ModSettings.addPage("General");

	local charmResistChance = pageGeneral.addRangeSetting("CharmResistChance", Defaults.CharmResistChance, 0, 100, 1, "Charm Resist Chance");
	charmResistChance.setDescription("Percentage chance for player characters to resist charm attempts. This does not modify the behaviour of vanilla Resolve checks caused by charm attempts.");

	local sleepResistChance = pageGeneral.addRangeSetting("SleepResistChance", Defaults.SleepResistChance, 0, 100, 1, "Sleep Resist Chance");
	sleepResistChance.setDescription("Percentage chance for player characters to resist sleep attempts. This does not modify the behaviour of vanilla Resolve checks caused by sleep attempts.");

	local rosterMax = pageGeneral.addRangeSetting("RosterMax", Defaults.RosterMax, 1, 27, 1, "Roster Threshold");
	rosterMax.setDescription("Determines the company size threshold above which the player character loses resistances provided by Avatar Resistances.");

	local modifyTooltip = pageGeneral.addBooleanSetting("ModifyTooltip", Defaults.ModifyTooltip, "Modify Tooltip");
	modifyTooltip.setDescription("Determines whether the player character trait tooltip is amended to reflect resistances provided by Avatar Resistances.");
});