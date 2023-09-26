local AR = ::RPGR_Avatar_Resistances;
::mods_hookExactClass("skills/actives/sleep_skill", function( object )
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

        if (::Math.rand(1, 100) > ::RPGR_Avatar_Resistances.Mod.ModSettings.getSetting("SleepResistChance").getValue())
        {
            return vanilla_onDelayedEffect(_tag);
        }

        local target = _tag.TargetTile.getEntity();

        if (target != null && ::RPGR_Avatar_Resistances.isActorEligible(target.getFlags()))
        {
            if (!_tag.User.isHiddenToPlayer() && !target.isHiddenToPlayer())
            {
                ::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " resists being put to sleep owing to a stalwart mind");
            }

            return;
        }

        return vanilla_onDelayedEffect(_tag);
    }

    AR.Standard.wrap(this, "onDelayedEffect", function( _tag )
    {
        if (!AR.Resistances.isWithinRosterThreshold())
        {
            return null;
        }

        if (::Math.rand(1, 100) > AR.Standard.getSetting("SleepResistChance"))
        {
            return null;
        }

        local target = _tag.TargetTile.getEntity();

        if (target == null)
        {
            return null;
        }

        if (!AR.isActorEligible(target.getFlags()))
        {
            return null;
        }

        if (!_tag.User.isHiddenToPlayer() && !target.isHiddenToPlayer())
        {
            ::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " resists being put to sleep owing to a stalwart mind");
            return AR.Defaults.TERMINATE;
        }

        return null;
    }, "overrideMethod");
});