local AR = ::RPGR_Avatar_Resistances;
::mods_hookExactClass("skills/actives/sleep_skill", function( _object )
{
	AR.Standard.wrap(_object, "onDelayedEffect", function( _tag )
	{
		if (!AR.Resistances.isWithinRosterThreshold())
		{
			return;
		}

		if (::Math.rand(1, 100) > AR.Standard.getSetting("SleepResistChance"))
		{
			return;
		}

		local target = _tag.TargetTile.getEntity();

		if (target == null)
		{
			return;
		}

		if (!AR.Resistances.isActorViable(target))
		{
			return;
		}

		if (!_tag.User.isHiddenToPlayer() && !target.isHiddenToPlayer())
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " resists being put to sleep owing to a stalwart mind");
			return AR.Defaults.TERMINATE;
		}

		return;
	}, "overrideMethod");
});