local AR = ::RPGR_Avatar_Resistances;
::mods_hookExactClass("skills/actives/swallow_whole_skill", function( object )
{
    AR.Standard.wrap(object, "onVerifyTarget", function( _originalValue, _originTile, _targetTile )
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

        ::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " fails to swallow " + ::Const.UI.getColorizedEntityName(target) + " whole");
		return false;
    }, "overrideReturn")
});