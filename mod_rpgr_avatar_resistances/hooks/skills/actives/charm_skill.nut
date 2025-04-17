::AR.Patcher.hook("scripts/skills/actives/charm_skill", function( p )
{
	::AR.Patcher.wrap(p, "onDelayedEffect", function( _tag )
	{
		if (!::AR.Utilities.isWithinRosterThreshold())
		{
			return;
		}

		if (::Math.rand(1, 100) > ::AR.Standard.getParameter("CharmResistChance"))
		{
			return;
		}

		local target = ::AR.Skills.fetchAndValidateTargetOnDelayedEffect(_tag);

		if (target == null)
		{
			return;
		}

		::AR.Skills.spawnCharmProjectileEffect(_tag.User, target, _tag.TargetTile);
		return false;
	}, "overrideMethod");
});