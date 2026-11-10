drawing
drawDINSemicircleOn: aCanvas
	| line |
	line := self lineWidth.
	self
		fillFrameRightArc: (Rectangle origin: self gateBoxDIN origin + (line @ 0) extent: self gateBoxDIN extent - (line @ 0))
		diameter: (self gateBoxDIN extent - (line @ 0)) * (2@1)
		on: aCanvas.

	aCanvas
		clipBy: (Rectangle origin: self gateBoxDIN origin - (line @ line) extent: (2 * line) @ (self gateBoxDIN extent y + (2 * line)))
		during: [ :sameCanvas |
			sameCanvas
				fillRectangle: self gateBoxDIN color: self fillColor;
				frameRectangle: self gateBoxDIN width: self lineWidth color: Color black]