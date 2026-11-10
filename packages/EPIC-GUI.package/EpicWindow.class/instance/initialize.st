initialization
initialize
	super initialize.
	self extent: 1000 px @ 600 px.
	self layoutPolicy: ProportionalLayout new.
	self postOpenInitialize.