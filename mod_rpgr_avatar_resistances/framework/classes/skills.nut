::AR.Skills <-
{
	function spawnCharmProjectileEffect( _casterObject, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (target == null)
		{
			::AP.Standard.log("Could not fetch target information on charm attempt.", true);
			return;
		}

		if (!::AR.Utilities.isActorViable(target))
		{
			return;
		}

		# The code below is adapted closely from the vanilla method.
		local time = ::Tactical.spawnProjectileEffect("effect_heart_01", _casterObject.getTile(), _targetTile, 0.33, 2.0, false, false);
		::Time.scheduleEvent(::TimeUnit.Virtual, time, function( _dummy = null )
		{
			if (_casterObject.isHiddenToPlayer())
			{
				return;
			}

			if (target.isHiddenToPlayer())
			{
				return;
			}

			::Tactical.EventLog.log(format(::AR.Utilities.getStringField("CharmResistNotification"), ::Const.UI.getColorizedEntityName(target)));
		}.bindenv(this), null);
	}
};