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

		if (!("TargetTile" in _tag) || _tag.TargetTile == null)
		{
			::AP.Standard.log("Could not fetch target tile information on charm attempt.", true);
			return;
		}

		::AR.Skills.spawnCharmProjectileEffect(_tag.User, _tag.TargetTile);
		return false;
	}, "overrideMethod");
});