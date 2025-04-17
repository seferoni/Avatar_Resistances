::AR.Utilities <-
{
	function getString( _fieldName )
	{
		return this.getStringField("Common")[_fieldName];
	}

	function getStringField( _fieldName )
	{
		return ::AR.Strings.getField("Generic", _fieldName);
	}

	function isActorViableForResistances( _actorObject )
	{
		if (!_actorObject.getSkills().hasSkill("trait.player"))
		{
			return false;
		}

		if (!::AR.Standard.getFlag("IsPlayerCharacter", _actorObject))
		{
			return false;
		}

		return true;
	}

	function isWithinRosterThreshold()
	{
		return ::World.getPlayerRoster().getAll().len() <= ::AR.Standard.getParameter("RosterMax");
	}
};