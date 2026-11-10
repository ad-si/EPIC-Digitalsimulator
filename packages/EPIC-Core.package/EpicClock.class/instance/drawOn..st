drawing
drawOn: aCanvas
	aCanvas 
		fillRectangle: self bounds color: self fillColor;
		frameRectangle: self bounds width: self lineWidth color: Color black.
	self drawString: '_|¯|_|¯' centeredAt: self center on: aCanvas