::AR.Utilities <-
{
	function getStringField( _fieldName )
	{
		return ::AR.Strings.getField("Generic", "Common")[_fieldName];
	}

	function isActorViable( _actor )
	{
		return ::AR.Standard.getFlag("IsPlayerCharacter", _actor);
	}

	function isWithinRosterThreshold()
	{
		return ::World.getPlayerRoster().getAll().len() <= ::AR.Standard.getParameter("RosterMax");
	}
};