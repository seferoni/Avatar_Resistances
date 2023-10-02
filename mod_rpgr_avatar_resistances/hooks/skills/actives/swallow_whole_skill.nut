local AR = ::RPGR_Avatar_Resistances;
::mods_hookExactClass("skills/actives/swallow_whole_skill", function( _object )
{
    AR.Standard.wrap(_object, "onVerifyTarget", function( _originalValue, _originTile, _targetTile )
    {
        if (!_originalValue)
        {
            return;
        }

        if (!AR.Standard.getSetting("SwallowImmunity"))
        {
            return;
        }

        if (!AR.Resistances.isWithinRosterThreshold())
        {
            return;
        }

        local actor = this.getContainer().getActor(),
        target = _targetTile.getEntity();

        if (target == null)
        {
            return;
        }

        if (!AR.Resistances.isActorViable(target))
        {
            return;
        }

        ::Tactical.EventLog.log(format("%s fails to swallow %s whole", ::Const.UI.getColorizedEntityName(actor), ::Const.UI.getColorizedEntityName(target)));
		return false;
    }, "overrideReturn")
});