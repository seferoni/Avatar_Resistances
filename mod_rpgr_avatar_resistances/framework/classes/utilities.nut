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

	function isActorViable( _actor )
	{
		return ::AR.Standard.getFlag("IsPlayerCharacter", _actor);
	}

	function isWithinRosterThreshold()
	{
		return ::World.getPlayerRoster().getAll().len() <= ::AR.Standard.getParameter("RosterMax");
	}
};