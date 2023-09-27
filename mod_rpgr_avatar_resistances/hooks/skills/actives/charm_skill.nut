local AR = ::RPGR_Avatar_Resistances;
::mods_hookExactClass("skills/actives/charm_skill", function( object )
{
    AR.Standard.wrap(object, "onDelayedEffect", function( _tag )
    {
        if (!AR.Resistances.isWithinRosterThreshold())
        {
            return;
        }

        if (::Math.rand(1, 100) > AR.Standard.getSetting("CharmResistChance"))
        {
            return;
        }

        local targetTile = _tag.TargetTile,
        target = targetTile.getEntity();

        if (target == null)
        {
            return;
        }

        if (!AR.Resistances.isActorViable(target))
        {
            return;
        }

        local user = _tag.User,
        time = ::Tactical.spawnProjectileEffect("effect_heart_01", user.getTile(), targetTile, 0.33, 2.0, false, false);
        ::Time.scheduleEvent(::TimeUnit.Virtual, time, function( _dummy = null )
        {
            if (!user.isHiddenToPlayer() && !target.isHiddenToPlayer())
            {
                ::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " resists being charmed owing to a stalwart mind");
            }
        }.bindenv(this), null);
        return false;
    }, "overrideMethod")
});