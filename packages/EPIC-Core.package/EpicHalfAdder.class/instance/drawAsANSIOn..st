drawing
drawAsANSIOn: aCanvas

	aCanvas 
		fillRectangle: self gateBoxANSI color: self fillColor;
		frameRectangle: self gateBoxANSI width: self lineWidth color: Color black.
	self drawLines: #('1-bit' 'half' 'adder') centeredAt: self gateBoxANSI center on: aCanvas.
	self drawANSIInputPortsOn: aCanvas.
	self drawANSIOutputPortsOn: aCanvas