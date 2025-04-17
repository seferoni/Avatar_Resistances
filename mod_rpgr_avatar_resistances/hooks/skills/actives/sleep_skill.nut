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

		local target = ::AR.Skills.fetchAndValidateTargetOnDelayedEffect(_tag);

		if (target == null)
		{
			return;
		}

		if (_tag.User.isHiddenToPlayer() || target.isHiddenToPlayer())
		{
			return;
		}

		::Tactical.EventLog.log(format(::AR.Utilities.getString("SleepResistNotification"), ::Const.UI.getColorizedEntityName(target)));
		return ::AR.Internal.TERMINATE;
	}, "overrideMethod");
});