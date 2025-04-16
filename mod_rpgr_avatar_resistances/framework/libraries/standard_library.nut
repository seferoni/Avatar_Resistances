::AR.Standard <-
{
	Case =
	{
		Upper = "toupper",
		Lower = "tolower"
	},
	Colour =
	{
		Cyan = "#0099cc",
		Gold = "#ffda0a"
		Green = "#2a5424",
		MutedGold = "#bcad8c",
		Orange = "#cc5500",
		Red = "#691a1a"
	},
	Tooltip =
	{
		id = 7,
		type = "text",
		text = ""
	}

	function appendToStringList( _string, _list, _separatorString = ", " )
	{
		local newString = _list == "" ? format("%s", _string) : format("%s%s%s", _list, _separatorString, _string);
		return newString;
	}

	function colourWrap( _text, _colour )
	{
		local string = _text;

		if (typeof _text != "string")
		{
			string = _text.tostring();
		}

		return format("[color=%s]%s[/color]", _colour, string)
	}

	function constructEntry( _icon, _text, _parentArray = null )
	{
		local entry = clone this.Tooltip;

		if (_icon != null)
		{
			entry.icon <- ::AR.Database.getIcon(_icon);
		}

		entry.text = _text;

		if (_parentArray == null)
		{
			return entry;
		}

		_parentArray.push(entry);
	}

	function createInclusiveLinearSequence( _start, _end, _step = 1 )
	{
		local sequence = [];

		for( local i = _start; i <= _end; i += _step )
		{
			sequence.push(i);
		}

		return sequence;
	}

	function extendArrayWithTableValues( _table, _targetArray )
	{
		foreach( key, value in _table )
		{
			_targetArray.push(value);
		}
	}

	function extendTable( _table, _targetTable )
	{
		foreach( key, value in _table )
		{
			_targetTable[key] <- value;
		}
	}

	function getArrayAsList( _array, _separatorString = ", " )
	{
		local list = "";

		foreach( entry in _array )
		{
			list = this.appendToStringList(entry, list, _separatorString);
		}

		return list;
	}

	function getFlag( _string, _object )
	{
		local flagValue = _object.getFlags().get(format("%s.%s", ::AR.ID, _string));

		if (flagValue == false)
		{
			flagValue = _object.getFlags().get(format("%s", _string));
		}

		return flagValue;
	}

	function getFlagAsInt( _string, _object )
	{
		local flagValue = _object.getFlags().getAsInt(format("%s.%s", ::AR.ID, _string));

		if (flagValue == 0)
		{
			flagValue = _object.getFlags().getAsInt(format("%s", _string));
		}

		return flagValue;
	}

	function getKey( _valueToMatch, _table )
	{
		foreach( key, value in _table )
		{
			if (value == _valueToMatch)
			{
				return key;
			}
		}
	}

	function getKeys( _table )
	{
		local returnArray = [];

		foreach( key, value in _table )
		{
			returnArray.push(key);
		}

		return returnArray;
	}

	function getNearestTen( _integer, _roundUp = false )
	{
		local naiveValue = ::Math.round(_integer / 10) * 10;

		if (_roundUp && naiveValue <= _integer)
		{
			return naiveValue + 10;
		}

		return naiveValue;
	}

	function getNormalisedParameter(  _parameterKey, _normalisationFactor = 100.0 )
	{
		return (this.getParameter(_parameterKey) / _normalisationFactor);
	}

	function getParameter( _parameterID )
	{
		if (::AR.Manager.isMSUInstalled())
		{
			return ::AR.Interfaces.MSU.ModSettings.getSetting(_parameterID).getValue();
		}

		local parameters = ::AR.Database.getSettingParameters();

		foreach( parameterKey, parameterTable in parameters )
		{
			if (_parameterID == parameterKey)
			{
				return parameterTable.Default;
			}
		}

		this.log(format("Invalid parameter key %s passed to getParameter.", _parameterKey), true);
	}

	function getPercentageParameter( _parameterID )
	{
		return (this.getParameter(_parameterID) / 100.0);
	}

	function getPlayerByID( _playerID )
	{
		local roster = ::World.getPlayerRoster().getAll();

		foreach( player in roster )
		{
			local candidateID = player.getID();

			if (_playerID == candidateID)
			{
				return player;
			}
		}

		return null;
	}

	function getTotalWeight( _weightedArray )
	{
		local totalWeight = 0;

		foreach( index, table in _weightedArray )
		{
			totalWeight += table.Weight;
		}

		return totalWeight;
	}

	function getListAsArray( _string )
	{
		local entries = split(_string, ", ");
		return entries;
	}

	function incrementFlag( _string, _value, _object, _isNative = false )
	{
		local flag = _isNative ? format("%s", _string) : format("%s.%s", ::AR.ID, _string);
		_object.getFlags().increment(flag, _value);
	}

	function isPlayerInProximityTo( _tile, _threshold = 6 )
	{
		return ::World.State.getPlayer().getTile().getDistanceTo(_tile) <= _threshold;
	}

	function isWeakRef( _object )
	{
		if (typeof _object != "instance")
		{
			return false;
		}

		if (!(_object instanceof ::WeakTableRef))
		{
			return false;
		}

		return true;
	}

	function isWithinRange( _value, _rangeArray )
	{
		if (_value < _rangeArray[0])
		{
			return false;
		}

		if (_rangeArray.len() == 1)
		{
			return true;
		}

		if (_value > _rangeArray[1])
		{
			return false;
		}

		return true;
	}

	function log( _string, _isError = false )
	{
		if (_isError)
		{
			::logError(format("[Parameters] %s", _string));
			return;
		}

		::logInfo(format("[Parameters] %s", _string));
	}

	function mapIntegerToAlphabet( _integer )
	{
		# Counting up from the ASCII equivalent of the letter "A".
		local ASCIIValue = 64 + _integer;
		return ASCIIValue.tochar();
	}

	function pickFromWeightedArray( _weightedArray )
	{
		local cumulativeWeight = 0;
		local randomNumber = ::Math.rand(0, this.getTotalWeight(_weightedArray));

		foreach( index, table in _weightedArray )
		{
			cumulativeWeight += table.Weight;

			if (cumulativeWeight >= randomNumber)
			{
				return table;
			}
		}
	}

	function push( _object, _targetArray )
	{
		if (_object == null)
		{
			return;
		}

		local entry = _object;

		if (typeof entry != "array")
		{
			entry = [_object];
		}

		_targetArray.extend(entry);
	}

	function randomFloat( _minFloat, _maxFloat )
	{
		return _minFloat + (1.0 * ::Math.rand() / RAND_MAX) * (_maxFloat - _minFloat);
	}

	function removeFromArray( _target, _array )
	{
		local targetArray = typeof _target == "array" ? _target : [_target];

		foreach( entry in targetArray )
		{
			local index = _array.find(entry);

			if (index != null)
			{
				_array.remove(index);
			}
		}
	}

	function replaceSubstring( _substring, _newSubstring, _targetString )
	{
		local startIndex = _targetString.find(_substring);

		if (startIndex == null)
		{
			return _targetString;
		}

		return format("%s%s%s", _targetString.slice(0, startIndex), _newSubstring, _targetString.slice(startIndex + _substring.len()));
	}

	function setCase( _string, _case )
	{
		local character = _string[0].tochar()[_case]();
		return format("%s%s", character, _string.slice(1));
	}

	function setFlag( _string, _value, _object, _isNative = false )
	{
		local flag = _isNative ? format("%s", _string) : format("%s.%s", ::AR.ID, _string);
		_object.getFlags().set(flag, _value);
	}

	function shuffleArray( _array )
	{	# This method uses the Fisher-Yates shuffle algorithm.
		local sequenceLength = _array.len();

		for( local i = 0; i < sequenceLength - 1; i++ )
		{
			local j = ::Math.rand(i, sequenceLength - 1);
			local valueA = _array[i];
			local valueB = _array[j];
			_array[j] = valueA;
			_array[i] = valueB;
		}
	}
};
