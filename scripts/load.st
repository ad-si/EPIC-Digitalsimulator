"Load EPIC into a fresh Squeak image and save it.
Usage: Squeak -headless <image> load.st <packages directory> <Metacello group>
On failure, writes load-error.txt next to the image and quits without saving."

[[Metacello new
	baseline: 'EPIC';
	repository: 'filetree://', (Smalltalk argumentAt: 1);
	load: (Smalltalk argumentAt: 2)]
		on: Warning do: [:warning | warning resume]]
	on: Error do: [:error |
		FileStream forceNewFileNamed: 'load-error.txt' do: [:file |
			file
				nextPutAll: error description; cr;
				nextPutAll: error signalerContext longStack].
		Smalltalk quitPrimitive].

"Close the welcome wizard and windows the base image opens on first start"
(Project current world submorphs select: [:morph |
	morph isSystemWindow or: [morph isKindOf: PreferenceWizardMorph]])
		do: [:morph | (morph isKindOf: ObjectlandStarterMorph)
			ifTrue: [morph closeBoxHit] "plain delete waits for a confirmation"
			ifFalse: [morph delete]].

Smalltalk snapshot: true andQuit: true.
