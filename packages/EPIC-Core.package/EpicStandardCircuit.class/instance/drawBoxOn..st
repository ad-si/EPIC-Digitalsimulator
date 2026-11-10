drawing
drawBoxOn: aCanvas
	aCanvas 
		fillRectangle: self bounds color: self fillColor;
		frameRectangle: self bounds width: self lineWidth color: Color black.
