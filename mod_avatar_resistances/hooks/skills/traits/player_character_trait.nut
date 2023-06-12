::mods_hookExactClass("skills/traits/player_character_trait", function( object )
    {
        local gT_nullCheck = "getTooltip" in object ? object.getTooltip : null;
        local parentName = object.SuperName;
        object.getTooltip <- function()
        {
            local tooltipArray = gT_nullCheck == null ? this[parentName].getTooltip() : gT_nullCheck();

            if (::Avatar_Resistances.Mod.ModSettings.getSetting("ModifyTooltip").getValue() == false)
            {
                return tooltipArray;
            }

            local roster = ::World.getPlayerRoster().getAll();

            if (roster.len() > ::Avatar_Resistances.Mod.ModSettings.getSetting("RosterMax").getValue())
            {
                return tooltipArray;
            }

            if (::Avatar_Resistances.Mod.ModSettings.getSetting("SwallowImmunity").getValue() == true)
            {
                tooltipArray.extend([
                    {
                        id = 10,
                        type = "text",
                        icon = "ui/icons/special.png",
                        text = "[color=" + ::Const.UI.Color.PositiveValue + "]Cannot[/color] be swallowed whole by nachzehrers"
                    }
                ]);
            }

            tooltipArray.extend([
                {
                    id = 10,
                    type = "text",
                    icon = "ui/icons/perks.png",
                    text = "[color=" + ::Const.UI.Color.PositiveValue + "]" + "+" + ::Math.floor(::Avatar_Resistances.Mod.ModSettings.getSetting("CharmResistChance").getValue()) + "[/color]% chance to resist charm effects"
                },
                {
                    id = 10,
                    type = "text",
                    icon = "ui/icons/perks.png",
                    text = "[color=" + ::Const.UI.Color.PositiveValue + "]" + "+" + ::Math.floor(::Avatar_Resistances.Mod.ModSettings.getSetting("SleepResistChance").getValue()) + "[/color]% chance to resist sleep effects"
                },
                {
                    id = 10,
                    type = "text",
                    icon = "ui/icons/warning.png",
                    text = "Loses resistances when the company grows above [color=" + ::Const.UI.Color.NegativeValue + "]" + ::Avatar_Resistances.Mod.ModSettings.getSetting("RosterMax").getValue() + "[/color] men"
                }
            ]);

            if (!::RPGR_AP_ModuleFound)
            {
                return tooltipArray;
            }

            local injuryCount = this.getContainer().getActor().getSkills().getAllSkillsOfType(::Const.SkillType.PermanentInjury).len();

            if (injuryCount > ::Avatar_Persistence.Mod.ModSettings.getSetting("PermanentInjuryThreshold").getValue())
            {
                return tooltipArray;
            }

            if (::Avatar_Persistence.Mod.ModSettings.getSetting("ModifyTooltip").getValue() == true)
            {
                tooltipArray.extend([
                    {
                        id = 10,
                        type = "text",
                        icon = "ui/icons/warning.png",
                        text = "Loses persistence when more than [color=" + ::Const.UI.Color.NegativeValue + "]" + ::Avatar_Persistence.Mod.ModSettings.getSetting("PermanentInjuryThreshold").getValue() + "[/color] permanent injuries are suffered at a time"
                    }
                ]);
            }

            return tooltipArray;
        }
    });