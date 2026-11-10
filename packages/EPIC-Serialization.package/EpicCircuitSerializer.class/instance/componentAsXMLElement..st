serialization
componentAsXMLElement: aComponent
	| component position |
	component := XMLElement named: 'component'.
	position := EPIC unscalePoint: aComponent position - self circuit innerOrigin.

	component attributes
		at: 'name' put: (self componentIDFor: aComponent);
		at: 'type' put: (aComponent fullyQualifiedName);
		at: 'x' put: position x asString;
		at: 'y' put: position y asString.
			
	^ component