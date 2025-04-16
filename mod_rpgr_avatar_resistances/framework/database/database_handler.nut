::AR.Database <-
{
	function createTables()
	{
		this.Settings <- {};
		this.Generic <- {};
	}

	function getExactField( _tableName, _subTableName, _fieldName )
	{
		return this[_tableName][_subTableName][_fieldName];
	}

	function getField( _tableName, _fieldName = "" )
	{
		return this.getTopLevelField(_tableName, _fieldName);
	}

	function getTopLevelField( _tableName, _fieldName )
	{
		if (!(_tableName) in this)
		{
			::AR.Standard.log(format("Could not find the specified database %s.", _tableName), true);
			return null;
		}

		if (_fieldName == "")
		{
			return this[_tableName];
		}

		if (!(_fieldName in this[_tableName]))
		{
			::AR.Standard.log(format("Could not find %s in the specified database %s.", _fieldName, _tableName), true);
			return null;
		}

		return this[_tableName][_fieldName];
	}

	function getIcon( _iconKey )
	{
		if (!_iconKey in this.Generic.Icons)
		{
			::AR.Standard.log(format("%s is not a valid icon key - this will break all associated tooltip elements.", _iconKey), true);
			return null;
		}

		return this.Generic.Icons[_iconKey];
	}

	function getSettingParameters()
	{
		local agglomeratedParameters = {};

		foreach( parameterType, parameterTable in this.Settings )
		{
			::AR.Standard.extendTable(parameterTable, agglomeratedParameters);
		}

		return agglomeratedParameters;
	}

	function getSettingCategories()
	{
		return ::AR.Standard.getKeys(this.Settings);
	}

	function loadFolder( _path )
	{
		::AR.Manager.includeFiles(format("mod_rpgr_avatar_resistances/framework/database/%s", _path));
	}

	function loadFiles()
	{
		this.loadFolder("dictionaries");
		this.loadFolder("settings");
	}

	function initialise()
	{
		this.createTables();
		this.loadFiles();
	}
};