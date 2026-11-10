drawing
drawAsEPICOn: aCanvas

	self drawBoxOn: aCanvas.
	self drawString: 'EQ' centeredAt: self center on: aCanvas
	