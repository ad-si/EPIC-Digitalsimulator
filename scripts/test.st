"Load the EPIC tests and run them.
Usage: Squeak -headless <image> test.st <packages directory> <UI scale factor in percent>
Writes test-results.txt next to the image and quits without saving.
The last line of test-results.txt is either PASSED or FAILED."

| result |
[
	[Metacello new
		baseline: 'EPIC';
		repository: 'filetree://', (Smalltalk argumentAt: 1);
		load: 'Tests']
			on: Warning do: [:warning | warning resume].

	Display uiScaleFactor: (Smalltalk argumentAt: 2) asNumber / 100.

	result := TestSuite new.
	((TestCase allSubclasses select: [:class | class category beginsWith: 'EPIC-Test'])
		reject: [:class | class isAbstract])
			do: [:class | result addTests: class buildSuite tests].
	result := result run.

	FileStream forceNewFileNamed: 'test-results.txt' do: [:file |
		file
			nextPutAll: 'Scale factor: ', RealEstateAgent scaleFactor printString; lf;
			nextPutAll: result printString; lf.
		result failures do: [:each | file nextPutAll: 'FAILURE: ', each printString; lf].
		result errors do: [:each | file nextPutAll: 'ERROR: ', each printString; lf].
		file nextPutAll: (result hasPassed ifTrue: ['PASSED'] ifFalse: ['FAILED'])]
] on: Error do: [:error |
	FileStream forceNewFileNamed: 'test-results.txt' do: [:file |
		file
			nextPutAll: error description; lf;
			nextPutAll: (error signalerContext longStack copyReplaceAll: String cr with: String lf); lf;
			nextPutAll: 'FAILED']].

Smalltalk quitPrimitive.
