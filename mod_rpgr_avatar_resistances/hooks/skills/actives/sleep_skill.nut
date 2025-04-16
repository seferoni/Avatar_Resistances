::AR.Patcher.hook("scripts/skills/actives/sleep_skill", function( p )
{
	::AR.Patcher.wrap(p, "onDelayedEffect", function( _tag )
	{
		if (!::AR.Utilities.isWithinRosterThreshold())
		{
			return;
		}

		if (::Math.rand(1, 100) > ::AR.Standard.getParameter("SleepResistChance"))
		{
			return;
		}

		if (!("TargetTile" in _tag) || _tag.TargetTile == null )
		{
			::AP.Standard.log("Could not fetch target tile information on sleep attempt.", true);
			return;
		}

		local target = _tag.TargetTile.getEntity();

		if (target == null)
		{
			::AP.Standard.log("Could not fetch target information on sleep attempt.", true);
			return;
		}

		if (!::AR.Utilities.isActorViable(target))
		{
			return;
		}

		if (_tag.User.isHiddenToPlayer() || target.isHiddenToPlayer())
		{
			return;
		}

		::Tactical.EventLog.log(format(::AR.Strings.Generic.SleepResistNotification, ::Const.UI.getColorizedEntityName(target)));
		return ::AR.Internal.TERMINATE;
	}, "overrideMethod");
});