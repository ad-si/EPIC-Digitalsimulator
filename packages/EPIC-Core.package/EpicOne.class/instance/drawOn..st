drawing
drawOn: aCanvas
	
	aCanvas fillRectangle:  self bounds color: self fillColor.
	aCanvas frameRectangle:  self bounds width: self lineWidth color: Color black.
	
	self drawString: '1' centeredAt: self center on: aCanvas
	
	
	