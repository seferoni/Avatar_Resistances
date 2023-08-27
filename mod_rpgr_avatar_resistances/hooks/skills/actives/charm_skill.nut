::mods_hookExactClass("skills/actives/charm_skill", function( object )
{
    local parentName = object.SuperName;

    local oDE_nullCheck = "onDelayedEffect" in object ? object.onDelayedEffect : null;
    object.onDelayedEffect <- function( _tag )
    {
        local vanilla_onDelayedEffect = oDE_nullCheck == null ? this[parentName].onDelayedEffect : oDE_nullCheck;

        if (!::RPGR_Avatar_Resistances.isWithinRosterThreshold())
        {
            return vanilla_onDelayedEffect(_tag);
        }

        if (::Math.rand(1, 100) > ::RPGR_Avatar_Resistances.Mod.ModSettings.getSetting("CharmResistChance").getValue())
        {
            return vanilla_onDelayedEffect(_tag);
        }

        local targetTile = _tag.TargetTile;
        local target = targetTile.getEntity();

        if (target == null)
        {
            return vanilla_onDelayedEffect(_tag);
        }

        if (!::RPGR_Avatar_Resistances.isActorEligible(target.getFlags()))
        {
            return vanilla_onDelayedEffect(_tag);
        }

        local _user = _tag.User;
        local time = ::Tactical.spawnProjectileEffect("effect_heart_01", _user.getTile(), targetTile, 0.33, 2.0, false, false);
        ::Time.scheduleEvent(::TimeUnit.Virtual, time, function( _dummy = null )
        {
            if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
            {
                ::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " resists being charmed owing to a stalwart mind");
            }

        }.bindenv(this), null);
        return false;
    }
});