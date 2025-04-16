::AR.Integrations.MSU <-
{
	function addPage( _pageID, _pageName = null )
	{
		return ::AR.Interfaces.MSU.ModSettings.addPage(_pageID, _pageName);
	}

	function appendElementToPage( _settingElement, _pageID )
	{
		this.getPage(_pageID).addElement(_settingElement);
	}

	function build()
	{
		this.Builders.Implicit.build();
	}

	function buildDescription( _settingElement )
	{
		local description = this.getElementDescription(_settingElement.getID());
		_settingElement.setDescription(description);
	}

	function createDivider( _elementID )
	{
		return ::MSU.Class.SettingsDivider(_elementID);
	}

	function createTables()
	{
		this.Builders <- {};
	}

	function getPage( _pageID )
	{
		return ::AR.Interfaces.MSU.ModSettings.getPage(_pageID);
	}

	function getPages()
	{
		return ::AR.Interfaces.MSU.ModSettings.getPanel().getPages();
	}

	function getElementDescription( _elementKey )
	{
		return this.getStringField(format("%sDescription", _elementKey));
	}

	function getElementName( _elementKey )
	{
		return this.getStringField(format("%sName", _elementKey));
	}

	function getStringField( _fieldName )
	{
		return ::AR.Strings.getField("Settings", "Common")[_fieldName];
	}

	function initialise()
	{
		this.createTables();
		this.loadBuilders();
		this.build();
	}

	function loadBuilders()
	{
		::AR.Manager.includeFiles("mod_rpgr_avatar_resistances/framework/integrations/msu/builders");
	}
};