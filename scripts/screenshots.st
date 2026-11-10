"Render screenshots of EPIC for the README.
Usage: Squeak -headless <image> screenshots.st <output directory> <UI scale factor in percent>
Writes the PNGs and a screenshots-error.txt on failure, and quits without saving."

| outputDir world window editor settle shoot circuitFrom halfAdder hexDisplay |
outputDir := FileDirectory on: (Smalltalk argumentAt: 1).

halfAdder := '<circuit name="half adder" xmlns="http://www.chaos-wg.net/epic/2010/07/circuitML">
	<interface><input/><output/></interface>
	<implementation><diagram>
		<components>
			<component name="a" type="epic.primitives.switch" x="60" y="80"/>
			<component name="b" type="epic.primitives.switch" x="60" y="200"/>
			<component name="xor" type="epic.primitives.xor" x="240" y="90"/>
			<component name="and" type="epic.primitives.and" x="240" y="210"/>
			<component name="sum" type="epic.primitives.lamp" x="420" y="100"/>
			<component name="carry" type="epic.primitives.lamp" x="420" y="220"/>
		</components>
		<connections>
			<wire startComponent="a" startPort="output1" targetComponent="xor" targetPort="input1"/>
			<wire startComponent="b" startPort="output1" targetComponent="xor" targetPort="input2"/>
			<wire startComponent="a" startPort="output1" targetComponent="and" targetPort="input1"/>
			<wire startComponent="b" startPort="output1" targetComponent="and" targetPort="input2"/>
			<wire startComponent="xor" startPort="output1" targetComponent="sum" targetPort="input1"/>
			<wire startComponent="and" startPort="output1" targetComponent="carry" targetPort="input1"/>
		</connections>
	</diagram></implementation>
</circuit>'.

hexDisplay := String new: 0 streamContents: [:stream |
	stream nextPutAll: '<circuit name="hex display" xmlns="http://www.chaos-wg.net/epic/2010/07/circuitML">
	<interface><input/><output/></interface>
	<implementation><diagram>
		<components>
			<component name="keys" type="epic.primitives.hexkeyboard" x="60" y="80"/>
			<component name="converter" type="epic.primitives.converter" x="260" y="100"/>
			<component name="display" type="epic.primitives.sevensegment" x="460" y="80"/>
		</components>
		<connections>'.
	1 to: 4 do: [:i | stream nextPutAll: '
			<wire startComponent="keys" startPort="output', i printString,
				'" targetComponent="converter" targetPort="input', i printString, '"/>'].
	1 to: 7 do: [:i | stream nextPutAll: '
			<wire startComponent="converter" startPort="output', i printString,
				'" targetComponent="display" targetPort="input', i printString, '"/>'].
	stream nextPutAll: '
		</connections>
	</diagram></implementation>
</circuit>'].

circuitFrom := [:xml | EpicCircuitXMLParser new parse:
	(XMLDOMParser parseDocumentFrom: xml readStream)].

"The simulator runs in its own process and needs time to propagate signals"
settle := [30 timesRepeat: [
	world doOneCycleNow.
	(Delay forMilliseconds: 50) wait]].

"Running the world resets the display to the size of the headless screen,
so the window is resized and rendered on its own afterwards"
shoot := [:name |
	settle value.
	window bounds: (0@0 extent: (900@550) * RealEstateAgent scaleFactor).
	window fullBounds.
	outputDir deleteFileNamed: name.
	PNGReadWriter putForm: window imageForm onFileNamed: (outputDir fullNameFor: name)].

[
	world := Project current world.
	"Must be set before EPIC opens, see start.st"
	Display relativeUiScaleFactor: (Smalltalk argumentAt: 2) asNumber / 100.
	window := EpicLockDownScript new lockDown; program.
	editor := window editorPanel.

	editor addInternalsOfCircuit: (circuitFrom value: halfAdder).
	(editor components detect: [:each | each isKindOf: EpicSwitch]) activate.
	shoot value: 'screenshot-half-adder.png'.

	(editor components select: [:each | each isKindOf: EpicSwitch]) last activate.
	window componentStyle: #ansi.
	shoot value: 'screenshot-ansi-style.png'.

	window componentStyle: #epic.
	editor navigationBar createNewTab.
	editor addInternalsOfCircuit: (circuitFrom value: hexDisplay).
	(editor components detect: [:each | each isKindOf: EpicHexKeyboard]) simulateWith: 16r5.
	window prototypeBox tabBar tabClicked: (window prototypeBox tabBar tabs at: 4).
	shoot value: 'screenshot-hex-display.png'
] on: Error do: [:error |
	FileStream forceNewFileNamed: 'screenshots-error.txt' do: [:file |
		file
			nextPutAll: error description; lf;
			nextPutAll: (error signalerContext longStack
				copyReplaceAll: String cr with: String lf)]].

Smalltalk quitPrimitive.
