drawing
drawAsIECOn: aCanvas

	aCanvas 
		fillRectangle: self gateBoxIEC color: self fillColor;
		frameRectangle: self gateBoxIEC width: self lineWidth color: Color black.
	self drawString: '=1' centeredAt: self gateBoxIEC center on: aCanvas.
	aCanvas 
		fillOval: self notDotIEC color: self fillColor;
		frameOval:  self notDotIEC width: self lineWidth color: Color black.
	self drawIECInputPortsOn: aCanvas.	
	aCanvas 
		line: self outputPorts first center 
		to: (self notDotIEC right) @ (self outputPorts first center y)
		width: self lineWidth color: Color black.