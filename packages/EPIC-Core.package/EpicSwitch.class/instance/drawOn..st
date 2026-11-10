drawing
drawOn: aCanvas
	
	aCanvas fillRectangle:  self bounds color: self fillColor.
	aCanvas frameRectangle:  self bounds width: self lineWidth color: Color black.
	
	self
		drawString: (self pressed ifTrue: ['___' ] ifFalse: ['_/ _' ])
		centeredAt: self center
		on: aCanvas
	