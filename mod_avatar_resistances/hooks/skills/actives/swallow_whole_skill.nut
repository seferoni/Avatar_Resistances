::mods_hookExactClass("skills/actives/swallow_whole_skill", function( object )
{
    local oVT_nullCheck = "onVerifyTarget" in object ? object.onVerifyTarget : null;
    local parentName = object.SuperName;
    object.onVerifyTarget <- function( _originTile, _targetTile )
    {
        local vanilla_onVerifyTarget = oVT_nullCheck == null ? this[parentName].onVerifyTarget(_originTile, _targetTile) : oVT_nullCheck(_originTile, _targetTile);
        local actor = this.getContainer().getActor();
        local target = _targetTile.getEntity();

        if (::Avatar_Resistances.Mod.ModSettings.getSetting("SwallowImmunity").getValue() == false)
        {
            return vanilla_onVerifyTarget;
        }

        local roster = ::World.getPlayerRoster().getAll();

        if (roster.len() > ::Avatar_Resistances.Mod.ModSettings.getSetting("RosterMax").getValue())
        {
            return vanilla_onVerifyTarget;
        }

        if (target.getFlags().has("IsPlayerCharacter"))
		{
            ::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " fails to swallow " + ::Const.UI.getColorizedEntityName(target) + " whole");
			return false;
		}

        return vanilla_onVerifyTarget;
    }
});