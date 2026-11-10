drawing
drawOn: aCanvas
	
	aCanvas fillRectangle: self bounds color: self fillColor.
	aCanvas frameRectangle: self bounds width: 1 px color: Color black.