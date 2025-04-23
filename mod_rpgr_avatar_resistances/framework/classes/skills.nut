::AR.Skills <-
{
	function fetchAndValidateTargetOnDelayedEffect( _effectTable )
	{
		if (!("TargetTile" in _effectTable) || _effectTable.TargetTile == null )
		{
			::AP.Standard.log("Could not fetch target tile information.", true);
			return null;
		}

		local target = _effectTable.TargetTile.getEntity();

		if (target == null)
		{
			::AP.Standard.log("Could not fetch target information.", true);
			return null;
		}

		if (!::AR.Utilities.isActorPlayerCharacter(target))
		{
			return null;
		}

		return target;
	}

	function spawnCharmProjectileEffect( _casterObject, _targetObject, _targetTile )
	{
		# The code below is adapted closely from the vanilla method.
		local time = ::Tactical.spawnProjectileEffect("effect_heart_01", _casterObject.getTile(), _targetTile, 0.33, 2.0, false, false);
		::Time.scheduleEvent(::TimeUnit.Virtual, time, function( _dummy = null )
		{
			if (_casterObject.isHiddenToPlayer())
			{
				return;
			}

			if (_targetObject.isHiddenToPlayer())
			{
				return;
			}

			::Tactical.EventLog.log(format(::AR.Utilities.getString("CharmResistNotification"), ::Const.UI.getColorizedEntityName(_targetObject)));
		}.bindenv(this), null);
	}
};