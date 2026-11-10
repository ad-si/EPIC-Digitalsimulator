initialization
initialize

	super initialize.
	self 
		extent: 80 px @ 80 px;
		keys: OrderedCollection new;
		initializeKeys;
		addKeysAsSubmorphs;
		reLayoutOutputPorts;
		simulate