::AR.Utilities <-
{
	// TODO: accessors here
	function getStringField( _fieldName )
	{
		return ::AR.Strings.getField("Generic", "Common")[_fieldName];
	}
};