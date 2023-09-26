::mods_hookExactClass("skills/actives/swallow_whole_skill", function( object )
{
    local parentName = object.SuperName;

    local oVT_nullCheck = "onVerifyTarget" in object ? object.onVerifyTarget : null;
    object.onVerifyTarget <- function( _originTile, _targetTile )
    {
        local vanilla_onVerifyTarget = oVT_nullCheck == null ? this[parentName].onVerifyTarget(_originTile, _targetTile) : oVT_nullCheck(_originTile, _targetTile);

        if (!vanilla_onVerifyTarget)
        {
            return vanilla_onVerifyTarget;
        }

        if (!::RPGR_Avatar_Resistances.Mod.ModSettings.getSetting("SwallowImmunity").getValue())
        {
            return vanilla_onVerifyTarget;
        }

        if (!::RPGR_Avatar_Resistances.isWithinRosterThreshold())
        {
            return vanilla_onVerifyTarget;
        }

        local actor = this.getContainer().getActor();
        local target = _targetTile.getEntity();

        if (target == null)
        {
            return vanilla_onVerifyTarget;
        }

        if (!::RPGR_Avatar_Resistances.isActorEligible(target.getFlags()))
        {
            return vanilla_onVerifyTarget;
        }

        ::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " fails to swallow " + ::Const.UI.getColorizedEntityName(target) + " whole");
		return false;
    }

    AP.Standard.wrap(this, "onVerifyTarget", function( _originTile, _targetTile )
    {
        if (!vanilla_onVerifyTarget)
        {
            return vanilla_onVerifyTarget;
        }

        if (!::RPGR_Avatar_Resistances.Mod.ModSettings.getSetting("SwallowImmunity").getValue())
        {
            return vanilla_onVerifyTarget;
        }

        if (!::RPGR_Avatar_Resistances.isWithinRosterThreshold())
        {
            return vanilla_onVerifyTarget;
        }

        local actor = this.getContainer().getActor();
        local target = _targetTile.getEntity();

        if (target == null)
        {
            return vanilla_onVerifyTarget;
        }

        if (!::RPGR_Avatar_Resistances.isActorEligible(target.getFlags()))
        {
            return vanilla_onVerifyTarget;
        }

        ::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " fails to swallow " + ::Const.UI.getColorizedEntityName(target) + " whole");
		return false;
    }, "overrideMethod")
});