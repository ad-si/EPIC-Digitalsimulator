"Lock down an image with EPIC loaded and save it as a stand-alone app image.
Usage: Squeak -headless <image> lockdown.st <UI scale factor in percent>
On failure, writes lockdown-error.txt next to the image and quits without saving."

[
	"Must be set before EPIC opens, see start.st"
	Display relativeUiScaleFactor: (Smalltalk argumentAt: 1) asNumber / 100.
	EpicLockDownScript new lockDown]
		on: Error do: [:error |
			FileStream forceNewFileNamed: 'lockdown-error.txt' do: [:file |
				file
					nextPutAll: error description; lf;
					nextPutAll: (error signalerContext longStack
						copyReplaceAll: String cr with: String lf)].
			Smalltalk quitPrimitive].

Smalltalk snapshot: true andQuit: true.
