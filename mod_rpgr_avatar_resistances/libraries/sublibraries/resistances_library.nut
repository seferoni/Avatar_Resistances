local AR = ::RPGR_Avatar_Resistances;
AR.Resistances <-
{
    function isActorViable( _actor )
    {
        return actor.getFlags().get("IsPlayerCharacter");
    }

    function isWithinRosterThreshold()
    {
        return ::World.getPlayerRoster().getAll().len() <= this.Mod.ModSettings.getSetting("RosterMax").getValue();
    }
}