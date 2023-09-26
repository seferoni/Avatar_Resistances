::mods_hookExactClass("skills/traits/player_character_trait", function( object )
{
    local parentName = object.SuperName;

    local gT_nullCheck = "getTooltip" in object ? object.getTooltip : null;
    object.getTooltip <- function()
    {
        local tooltipArray = gT_nullCheck == null ? this[parentName].getTooltip() : gT_nullCheck();

        if (!::RPGR_Avatar_Resistances.Mod.ModSettings.getSetting("ModifyTooltip").getValue())
        {
            return tooltipArray;
        }

        if (!::RPGR_Avatar_Resistances.isWithinRosterThreshold())
        {
            return tooltipArray;
        }

        local id = 10;
        local type = "text";

        if (::RPGR_Avatar_Resistances.Mod.ModSettings.getSetting("SwallowImmunity").getValue())
        {
            tooltipArray.append(::RPGR_Avatar_Resistances.generateTooltipTableEntry(id, type, "special.png", "[color=" + ::Const.UI.Color.PositiveValue + "]Cannot[/color] be swallowed whole by nachzehrers"));
        }

        tooltipArray.extend([
            ::RPGR_Avatar_Resistances.generateTooltipTableEntry(id, type, "perks.png", "[color=" + ::Const.UI.Color.PositiveValue + "]" + "+" + ::RPGR_Avatar_Resistances.Mod.ModSettings.getSetting("CharmResistChance").getValue() + "[/color]% chance to resist charm effects"),
            ::RPGR_Avatar_Resistances.generateTooltipTableEntry(id, type, "perks.png", "[color=" + ::Const.UI.Color.PositiveValue + "]" + "+" + ::RPGR_Avatar_Resistances.Mod.ModSettings.getSetting("SleepResistChance").getValue() + "[/color]% chance to resist sleep effects"),
            ::RPGR_Avatar_Resistances.generateTooltipTableEntry(id, type, "warning.png", "Loses resistances when the company grows above [color=" + ::Const.UI.Color.NegativeValue + "]" + ::RPGR_Avatar_Resistances.Mod.ModSettings.getSetting("RosterMax").getValue() + "[/color] men")
        ]);

        if (!::RPGR_AP_ModuleFound)
        {
            return tooltipArray;
        }

        if (!::RPGR_Avatar_Persistence.Persistence.isWithinInjuryThreshold(this.getContainer().getActor()))
        {
            return tooltipArray;
        }

        if (::RPGR_Avatar_Persistence.Standard.getSetting("ModifyTooltip"))
        {
            tooltipArray.append(::RPGR_Avatar_Resistances.generateTooltipTableEntry(id, type, "warning.png", "Loses persistence when " + ::RPGR_Avatar_Persistence.Persistence.getThresholdWarningText()));
        }

        return tooltipArray;
    }
});