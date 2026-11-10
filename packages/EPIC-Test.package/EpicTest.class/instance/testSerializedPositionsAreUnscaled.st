serialization testing
testSerializedPositionsAreUnscaled
	"Circuit files store coordinates at 100% scale, so a circuit saved at one UI scale factor opens with the same layout at any other. Run the tests at a scale factor other than 100% to exercise the conversion."
	| circuit switch lamp wire xml parsed parsedLamp |
	circuit := EpicCustomCircuit new.
	switch := EpicSwitch new.
	lamp := EpicLamp new.
	circuit
		addSubComponent: switch;
		addSubComponent: lamp.
	lamp position: (EPIC scalePoint: 30 @ 60).
	wire := EpicWire from: switch outputPorts first to: lamp inputPorts first.
	wire addAnchorPoint: (EPIC scalePoint: 90 @ 120).

	xml := circuit asXMLDocument asString.
	circuit delete.
	self
		assert: (xml includesSubstring: 'x="30" y="60"');
		assert: (xml includesSubstring: 'x="90" y="120"').

	parsed := EpicCircuitXMLParser new parseStream: xml readStream.
	[parsedLamp := parsed subComponents detect: [:each | each isKindOf: EpicLamp].
	self
		assert: parsedLamp position = (EPIC scalePoint: 30 @ 60);
		assert: parsed subWires first anchorPoints first point = (EPIC scalePoint: 90 @ 120)]
		ensure: [parsed delete]
