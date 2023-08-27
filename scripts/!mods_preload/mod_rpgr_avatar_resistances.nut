::RPGR_Avatar_Resistances <-
{
    ID = "mod_rpgr_avatar_resistances",
    Name = "RPG Rebalance - Avatar Resistances",
    Version = "1.4.1",

    function generateTooltipTableEntry( _id, _type, _icon, _text )
    {
        local tableEntry =
        {
            id = _id,
            type = _type,
            icon = "ui/icons/" + _icon,
            text = _text
        }

        return tableEntry;
    }

    function isActorEligible( _flags )
    {
        return _flags.get("IsPlayerCharacter");
    }

    function isWithinRosterThreshold()
    {
        return ::World.getPlayerRoster().getAll().len() <= this.Mod.ModSettings.getSetting("RosterMax").getValue();
    }
};

::mods_registerMod(::RPGR_Avatar_Resistances.ID, ::RPGR_Avatar_Resistances.Version, ::RPGR_Avatar_Resistances.Name);
::mods_queue(::RPGR_Avatar_Resistances.ID, "mod_msu(>=1.2.6)", function()
{
    ::RPGR_Avatar_Resistances.Mod <- ::MSU.Class.Mod(::RPGR_Avatar_Resistances.ID, ::RPGR_Avatar_Resistances.Version, ::RPGR_Avatar_Resistances.Name);
    ::RPGR_AP_ModuleFound <- ::mods_getRegisteredMod("mod_rpgr_avatar_persistence") != null;

    local pageGeneral = ::RPGR_Avatar_Resistances.Mod.ModSettings.addPage("General");

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

    foreach( file in ::IO.enumerateFiles("mod_rpgr_avatar_resistances/hooks") )
    {
        ::include(file);
    }
});