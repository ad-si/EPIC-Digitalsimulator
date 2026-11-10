drawing
drawAsEPICOn: aCanvas
	
	self drawBoxOn: aCanvas.
	self drawString: 'XNOR' centeredAt: self center on: aCanvas
	