::mods_hookExactClass("skills/actives/charm_skill", function( object )
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

            if (target != null && target.getFlags().get("IsPlayerCharacter") && ::Math.rand(1, 100) <= ::Avatar_Resistances.Mod.ModSettings.getSetting("CharmResistChance").getValue())
			{
                local _user = _tag.User;
                local time = ::Tactical.spawnProjectileEffect("effect_heart_01", _user.getTile(), _targetTile, 0.33, 2.0, false, false);
                ::Time.scheduleEvent(::TimeUnit.Virtual, time, function( _dummy = null )
                {
                    if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
                    {
                        ::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " resists being charmed owing to a stalwart mind");
                    }

                }.bindenv(this), null);
                return false;
			}

            return vanilla_onDelayedEffect( _tag );
        }
    });