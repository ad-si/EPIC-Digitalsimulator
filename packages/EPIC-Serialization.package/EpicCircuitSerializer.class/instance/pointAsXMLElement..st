serialization
pointAsXMLElement: anEpicAnchor
	| point pointElement |
	pointElement := XMLElement named: 'point'.
	
	point := EPIC unscalePoint: anEpicAnchor point - self circuit innerOrigin.

	pointElement attributes
		at: 'x' put: point x asString;
		at: 'y' put: point y asString.
		
	^ pointElement