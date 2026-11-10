initialization
initializeSegments
	| long short |
	long := 30 px.
	short := 15 px.
	self bottomSegment: (EpicDisplaySegment horizontalAt: self center + (0 @ long)).
	self bottomLeftSegment: (EpicDisplaySegment verticalAt: self center + (short negated @ short)).
	self bottomRightSegment: (EpicDisplaySegment verticalAt: self center + (short @ short)).
	self centerSegment: (EpicDisplaySegment horizontalAt: self center).
	self topSegment: (EpicDisplaySegment horizontalAt: self center - (0 @ long)).
	self topLeftSegment: (EpicDisplaySegment verticalAt: self center - (short @ short)).
	self topRightSegment: (EpicDisplaySegment verticalAt: self center + (short @ short negated)).