drawing
drawOn: aCanvas
	aCanvas
		fillRectangle: self bounds color: self fillColor;
		frameRectangle: self bounds width: self lineWidth color: Color black.
	self drawString: self displayName centeredAt: self center on: aCanvas