::AR.Utilities <-
{
	function getCurrentRosterSize()
	{
		return ::World.getPlayerRoster().getAll().len();
	}

	function getString( _fieldName )
	{
		return this.getStringField("Common")[_fieldName];
	}

	function getStringField( _fieldName )
	{
		return ::AR.Strings.getField("Generic", _fieldName);
	}

	function isActorPlayerCharacter( _actorObject )
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
		return this.getCurrentRosterSize() <= ::AR.Standard.getParameter("RosterMax");
	}
};