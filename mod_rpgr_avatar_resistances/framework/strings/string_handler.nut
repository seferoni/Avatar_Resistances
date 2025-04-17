::AR.Strings <-
{
	function createTables()
	{
		this.Generic <- {};
		this.Settings <- {};
	}

	function compileFragments( _fragmentsArray, _colour )
	{
		local compiledString = "";

		if (_fragmentsArray.len() % 2 != 0)
		{
			_fragmentsArray.push("");
		}

		for( local i = 0; i < _fragmentsArray.len(); i++ )
		{
			local fragment = (_colour != null && i % 2 != 0) ? ::AR.Standard.colourWrap(_fragmentsArray[i], _colour) : _fragmentsArray[i];
			compiledString = ::AR.Standard.appendToStringList(fragment, compiledString, " ");
		}

		return compiledString;
	}

	function getField( _tableName, _fieldName )
	{
		local field = this.getTopLevelField(_tableName, _fieldName);

		if (field == null)
		{
			::AR.Standard.log(format("Could not find %s in the specified string database %s.", _fieldName, _tableName), true);
		}

		return field;
	}

	function getFragmentsAsCompiledString( _fragmentBase, _tableKey, _subTableKey = null, _colour = ::AR.Standard.Colour.Red )
	{
		local fragmentsArray = this.getFragmentsAsSortedArray(_fragmentBase, _tableKey, _subTableKey);
		return this.compileFragments(fragmentsArray, _colour);
	}

	function getFragmentsAsSortedArray( _fragmentBase, _tableKey, _subTableKey )
	{
		local fragmentKeys = [];
		local database = _subTableKey == null ? this[_tableKey] : this[_tableKey][_subTableKey];

		foreach( key, string in database )
		{
			if (key.find(_fragmentBase) != null)
			{
				fragmentKeys.push(key);
			}
		}

		fragmentKeys.sort();
		return fragmentKeys.map(@(_fragmentKey) database[_fragmentKey]);
	}

	function getTopLevelField( _tableName, _fieldName )
	{
		if (!(_fieldName in this[_tableName]))
		{
			return null;
		}

		return this[_tableName][_fieldName];
	}

	function initialise()
	{
		this.createTables();
		this.loadFiles();
	}

	function loadFiles()
	{
		this.loadFolder("generic");
		this.loadFolder("settings");
	}

	function loadFolder( _path )
	{
		::AR.Manager.includeFiles(format("mod_rpgr_avatar_resistances/framework/strings/%s", _path));
	}
};