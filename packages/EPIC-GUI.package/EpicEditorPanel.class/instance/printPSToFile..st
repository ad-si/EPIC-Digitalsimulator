output
printPSToFile: aFileStream
	"Print this morph as postscript to aFileStream."
	| rotateFlag psCanvasType previousAuthorName postscript |
	psCanvasType := PostscriptCanvas defaultCanvasType.
	rotateFlag := (UIManager default chooseFrom: {
		'portrait (tall)' translated.
		'landscape (wide)' translated.
	} title: 'Choose orientation...' translated) = 2.

	"The PostScript header contains the author name,
	for which Squeak would otherwise prompt the user."
	previousAuthorName := Utilities authorNamePerSe.
	previousAuthorName ifEmpty: [Utilities authorName: 'EPIC'].
	postscript := [psCanvasType morphAsPostscript: self rotated: rotateFlag]
		ensure: [Utilities authorName: previousAuthorName].

	(aFileStream converter: TextConverter defaultSystemConverter)
		nextPutAll: postscript;
		close
