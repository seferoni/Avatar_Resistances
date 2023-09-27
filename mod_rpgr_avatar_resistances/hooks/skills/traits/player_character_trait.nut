local AR = ::RPGR_Avatar_Resistances;
::mods_hookExactClass("skills/traits/player_character_trait", function( object )
{
    AR.Standard.wrap(object, "getTooltip", function( ... )
    {
        local tooltipArray = AR.Standard.getOriginalResult(vargv);

        if (!AR.Standard.getSetting("ModifyTooltip"))
        {
            return tooltipArray;
        }

        if (!AR.Resistances.isWithinRosterThreshold())
        {
            return tooltipArray;
        }

        local id = 10, type = "text";

        if (AR.Standard.getSetting("SwallowImmunity"))
        {
            tooltipArray.push(AR.Standard.makeTooltip(id, type, "special.png", format("%s be swallowed whole by nachzehrers", AR.Standard.colourWrap("Cannot", "PositiveValue"))))
        }

        tooltipArray.extend([
            AR.Standard.makeTooltip(id, type, "perks.png", format("%s%% chance to resist charm effects", AR.Standard.colourWrap(format("+%i", AR.Standard.getSetting("CharmResistChance")), "PositiveValue"))),
            AR.Standard.makeTooltip(id, type, "perks.png", format("%s%% chance to resist sleep effects", AR.Standard.colourWrap(format("+%i", AR.Standard.getSetting("SleepResistChance")), "PositiveValue"))),
            AR.Standard.makeTooltip(id, type, "warning.png", format("Loses resistances when the company grows above %s men", AR.Standard.colourWrap(AR.Standard.getSetting("RosterMax"), "NegativeValue")))
        ]);

        if (!AR.Internal.APFound)
        {
            return tooltipArray;
        }

        local AP = ::RPGR_Avatar_Persistence;

        if (!AP.Persistence.isWithinInjuryThreshold(this.getContainer().getActor()))
        {
            return tooltipArray;
        }

        if (AP.Standard.getSetting("ModifyTooltip"))
        {
            tooltipArray.append(AR.Standard.makeTooltip(id, type, "warning.png", format("Loses persistence when %s", AP.Persistence.getThresholdWarningText())));
        }

        return tooltipArray;
    }, "overrideReturn");
});