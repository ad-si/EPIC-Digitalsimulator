parsing
parsePosition: anXMLElement
	| x y |
	x := (anXMLElement attributeAt: 'x') asInteger.
	y := (anXMLElement attributeAt: 'y') asInteger.
	
	^ EPIC scalePoint: x @ y