"Open EPIC.
Usage: Squeak <image> start.st <UI scale factor in percent>
The scale factor must be set before EPIC opens, because EPIC computes its
geometry from it when building its morphs."

WorldState addDeferredUIMessage: [
	Display relativeUiScaleFactor: (Smalltalk argumentAt: 1) asNumber / 100.
	WorldState addDeferredUIMessage: [EPIC startProgram]].
