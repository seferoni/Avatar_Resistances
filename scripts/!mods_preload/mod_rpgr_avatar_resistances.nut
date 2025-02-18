::AR <-
{
	ID = "mod_rpgr_avatar_resistances",
	Name = "RPG Rebalance - Avatar Resistances",
	Version = "2.0.0",
	Internal =
	{
		ManagerPath = "mod_rpgr_avatar_resistances/framework/internal/manager.nut",
		TERMINATE = "__end"
	}

	function loadManager()
	{
		::include(this.Internal.ManagerPath);
	}

	function initialise()
	{
		this.loadManager();
		this.Manager.awake();
		this.Manager.queue();
	}
};

::AR.initialise();