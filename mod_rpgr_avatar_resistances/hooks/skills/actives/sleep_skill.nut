::AR.Patcher.hook("scripts/skills/actives/sleep_skill", function( p )
{
	::AR.Patcher.wrap(p, "onDelayedEffect", function( _tag )
	{
		if (!::AR.Resistances.isWithinRosterThreshold())
		{
			return;
		}

		if (::Math.rand(1, 100) > ::AR.Standard.getParameter("SleepResistChance"))
		{
			return;
		}

		local target = _tag.TargetTile.getEntity();

		if (target == null)
		{
			return;
		}

		if (!::AR.Resistances.isActorViable(target))
		{
			return;
		}

		if (!_tag.User.isHiddenToPlayer() && !target.isHiddenToPlayer())
		{
			::Tactical.EventLog.log(format(::AR.Strings.Generic.SleepResistNotification, ::Const.UI.getColorizedEntityName(target)));
			return ::AR.Internal.TERMINATE;
		}
	}, "overrideMethod");
});