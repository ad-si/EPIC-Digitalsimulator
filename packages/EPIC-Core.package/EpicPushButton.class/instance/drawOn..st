drawing
drawOn: aCanvas
	
	aCanvas fillRectangle:  self bounds color: self fillColor.
	aCanvas frameRectangle:  self bounds width: self lineWidth color: Color black.
	
	self
		drawString: (self pressed ifTrue: ['-|¯|-' ] ifFalse: ['-|_|-' ])
		centeredAt: self center
		on: aCanvas
	