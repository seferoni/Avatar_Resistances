::Avatar_Resistances <-
{
    ID = "mod_avatar_resistances",
    Name = "RPG Rebalance - Avatar Resistances",
    Version = "1.4.0"
};

::mods_registerMod(::Avatar_Resistances.ID, ::Avatar_Resistances.Version, ::Avatar_Resistances.Name);
::mods_queue(::Avatar_Resistances.ID, "mod_msu(>=1.2.6)", function()
{
    ::Avatar_Resistances.Mod <- ::MSU.Class.Mod(::Avatar_Resistances.ID, ::Avatar_Resistances.Version, ::Avatar_Resistances.Name);
    ::RPGR_AP_ModuleFound <- ::mods_getRegisteredMod("mod_avatar_persistence") != null;
    // pages
    local pageGeneral = ::Avatar_Resistances.Mod.ModSettings.addPage("General");
    // settings
    local charmResistChance = pageGeneral.addRangeSetting("CharmResistChance", 100, 0, 100, 1.0, "Charm Resist Chance");
    charmResistChance.setDescription("Percentage chance for player characters to resist charm attempts.");

    local sleepResistChance = pageGeneral.addRangeSetting("SleepResistChance", 25, 0, 100, 1.0, "Sleep Resist Chance");
    sleepResistChance.setDescription("Percentage chance for player characters to resist sleep attempts.");

    local rosterMax = pageGeneral.addRangeSetting("RosterMax", 12, 1, 27, 1, "Roster Threshold");
    rosterMax.setDescription("Determines the company size threshold above which the player character loses their resistances to charm and sleep attempts.");

    local modifyTooltip = pageGeneral.addBooleanSetting("ModifyTooltip", true, "Modify Tooltip");
    modifyTooltip.setDescription("Determines whether the tooltip is amended to reflect the player character's new resistances.");

    local swallowImmunity = pageGeneral.addBooleanSetting("SwallowImmunity", true, "Swallow Immunity");
    swallowImmunity.setDescription("Determines whether player characters can be swallowed whole by nachzehrers.");
    // MSU setup ends here
    foreach( file in ::IO.enumerateFiles("mod_avatar_resistances/hooks") )
    {
        ::include(file);
    }
});