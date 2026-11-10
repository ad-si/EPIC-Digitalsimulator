initialization
initialize
	super initialize.
	self 
		extent: 50 px @ 72 px;
		initializeSegments;
		addSegmentsAsSubmorphs;
		reLayoutInputPorts