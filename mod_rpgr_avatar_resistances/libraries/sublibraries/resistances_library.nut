local AR = ::RPGR_Avatar_Resistances;
AR.Resistances <-
{
    function isActorViable( _actor )
    {
        return AR.Standard.getFlag("IsPlayerCharacter", _actor);
    }

    function isWithinRosterThreshold()
    {
        return ::World.getPlayerRoster().getAll().len() <= AR.Standard.getSetting("RosterMax");
    }
}