drawing
drawOn: aCanvas
	| |
	aCanvas fillRectangle:  self bounds color: self fillColor.
	aCanvas frameRectangle:  self bounds width: self lineWidth color: Color black.
	