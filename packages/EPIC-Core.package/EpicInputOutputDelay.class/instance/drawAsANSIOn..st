drawing
drawAsANSIOn: aCanvas

	aCanvas 
		fillRectangle: self gateBoxANSI color: self fillColor;
		frameRectangle: self gateBoxANSI width: self lineWidth color: Color black.
	self drawLines: #('WA' 'IT') centeredAt: self gateBoxANSI center on: aCanvas.
	self drawANSIInputPortsOn: aCanvas.
	self drawANSIIOutputPortsOn: aCanvas
	
