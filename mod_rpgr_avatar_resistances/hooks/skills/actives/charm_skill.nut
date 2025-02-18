::AR.Patcher.hook("scripts/skills/actives/charm_skill", function( p )
{
	::AR.Patcher.wrap(p, "onDelayedEffect", function( _tag )
	{
		if (!::AR.Resistances.isWithinRosterThreshold())
		{
			return;
		}

		if (::Math.rand(1, 100) > ::AR.Standard.getSetting("CharmResistChance"))
		{
			return;
		}

		local targetTile = _tag.TargetTile;
		local target = targetTile.getEntity();

		if (target == null)
		{
			return;
		}

		if (!::AR.Resistances.isActorViable(target))
		{
			return;
		}

		# The code below is adapted closely from the vanilla method.
		local user = _tag.User;
		local time = ::Tactical.spawnProjectileEffect("effect_heart_01", user.getTile(), targetTile, 0.33, 2.0, false, false);
		::Time.scheduleEvent(::TimeUnit.Virtual, time, function( _dummy = null )
		{
			if (!user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				::Tactical.EventLog.log(format(::AR.Strings.Generic.CharmResistNotification, ::Const.UI.getColorizedEntityName(target)));
			}
		}.bindenv(this), null);

		return false;
	}, "overrideMethod");
});