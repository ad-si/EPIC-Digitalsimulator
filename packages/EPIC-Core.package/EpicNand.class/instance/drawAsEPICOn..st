drawing
drawAsEPICOn: aCanvas
	
	self drawBoxOn: aCanvas.
	self drawString: 'NAND' centeredAt: self center on: aCanvas
	