::RPGR_Avatar_Resistances <-
{
    ID = "mod_rpgr_avatar_resistances",
    Name = "RPG Rebalance - Avatar Resistances",
    Version = "1.5.0",
    Internal =
    {
        TERMINATE = "__end"
    },
    Defaults =
    {
        CharmResistChance = 100,
        SleepResistChance = 25,
        RosterMax = 1,
        ModifyTooltip = true,
        SwallowImmunity = true
    }
};

local AR = ::RPGR_Avatar_Resistances;
::mods_registerMod(AR.ID, AR.Version, AR.Name);
::mods_queue(AR.ID, ">mod_msu(>=1.2.6)", function()
{
    AR.Internal.MSUFound <- ::mods_getRegisteredMod("mod_msu") != null;
    AR.Internal.APFound <- ::mods_getRegisteredMod("mod_rpgr_avatar_persistence") != null;

    if (!AR.Internal.MSUFound)
    {
        return;
    }

    AR.Mod <- ::MSU.Class.Mod(AR.ID, AR.Version, AR.Name);

    local pageGeneral = AR.Mod.ModSettings.addPage("General");

    local charmResistChance = pageGeneral.addRangeSetting("CharmResistChance", 100, 0, 100, 1, "Charm Resist Chance");
    charmResistChance.setDescription("Percentage chance for player characters to resist charm attempts.");

    local sleepResistChance = pageGeneral.addRangeSetting("SleepResistChance", 25, 0, 100, 1, "Sleep Resist Chance");
    sleepResistChance.setDescription("Percentage chance for player characters to resist sleep attempts.");

    local rosterMax = pageGeneral.addRangeSetting("RosterMax", 1, 1, 27, 1, "Roster Threshold");
    rosterMax.setDescription("Determines the company size threshold above which the player character loses resistances provided by Avatar Resistances.");

    local modifyTooltip = pageGeneral.addBooleanSetting("ModifyTooltip", true, "Modify Tooltip");
    modifyTooltip.setDescription("Determines whether the player character trait tooltip is amended to reflect resistances provided by Avatar Resistances.");

    local swallowImmunity = pageGeneral.addBooleanSetting("SwallowImmunity", true, "Swallow Immunity");
    swallowImmunity.setDescription("Determines whether player characters can be swallowed whole by nachzehrers.");
});