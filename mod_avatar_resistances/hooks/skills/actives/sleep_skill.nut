::mods_hookExactClass("skills/actives/sleep_skill", function( object )
    {
        local oDE_nullCheck = "onDelayedEffect" in object ? object.onDelayedEffect : null;
        local parentName = object.SuperName;
        object.onDelayedEffect <- function( _tag )
        {
            local vanilla_onDelayedEffect = oDE_nullCheck == null ? this[parentName].onDelayedEffect : oDE_nullCheck;
            local roster = ::World.getPlayerRoster().getAll();

            if (roster.len() > ::Avatar_Resistances.Mod.ModSettings.getSetting("RosterMax").getValue())
            {
                return vanilla_onDelayedEffect(_tag);
            }

		    local _targetTile = _tag.TargetTile;
            local target = _targetTile.getEntity();

            if (target != null && target.getFlags().get("IsPlayerCharacter") && ::Math.rand(1, 100) <= ::Avatar_Resistances.Mod.ModSettings.getSetting("SleepResistChance").getValue())
			{
                local _user = _tag.User;

				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " resists being put to sleep owing to a stalwart mind");
				}

				return;
			}

            return vanilla_onDelayedEffect(_tag);
        }
    });