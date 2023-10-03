local AR = ::RPGR_Avatar_Resistances;
::mods_hookExactClass("skills/traits/player_character_trait", function( _object )
{
    AR.Standard.wrap(_object, "getTooltip", function( _tooltipArray )
    {
        if (!AR.Standard.getSetting("ModifyTooltip"))
        {
            return;
        }

        if (!AR.Resistances.isWithinRosterThreshold())
        {
            return;
        }

        if (AR.Standard.getSetting("SwallowImmunity"))
        {
            _tooltipArray.push({id = 10, type = "text", icon = "special.png", text = format("%s be swallowed whole by nachzehrers", AR.Standard.colourWrap("Cannot", "PositiveValue"))});
        }

        _tooltipArray.extend([
            {id = 10, type = "text", icon = "perks.png", text = format("%s%% chance to resist charm effects", AR.Standard.colourWrap(format("+%i", AR.Standard.getSetting("CharmResistChance")), "PositiveValue"))},
            {id = 10, type = "text", icon = "perks.png", text = format("%s%% chance to resist sleep effects", AR.Standard.colourWrap(format("+%i", AR.Standard.getSetting("SleepResistChance")), "PositiveValue"))},
            {id = 10, type = "text", icon = "warning.png", text = format("Loses resistances when the company grows above %s men", AR.Standard.colourWrap(AR.Standard.getSetting("RosterMax"), "NegativeValue"))}
        ]);

        if (!AR.Internal.APFound)
        {
            return _tooltipArray;
        }

        local AP = ::RPGR_Avatar_Persistence;

        if (!AP.Persistence.isWithinInjuryThreshold(this.getContainer().getActor()))
        {
            return _tooltipArray;
        }

        if (AP.Standard.getSetting("ModifyTooltip"))
        {
            _tooltipArray.push({id = 10, type = "text", icon = "warning.png", text = format("Loses persistence when %s", AP.Persistence.getThresholdWarningText())});
        }

        return _tooltipArray;
    }, "overrideReturn");
});