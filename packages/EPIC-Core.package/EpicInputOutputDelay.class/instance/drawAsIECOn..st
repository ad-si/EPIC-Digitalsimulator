drawing
drawAsIECOn: aCanvas

	aCanvas 
		fillRectangle: self gateBoxIEC color: self fillColor;
		frameRectangle: self gateBoxIEC width: self lineWidth color: Color black.
	self drawString: 'WAIT' centeredAt: self gateBoxIEC center on: aCanvas.
	self drawIECInputPortsOn: aCanvas.
	self drawIECOutputPortsOn: aCanvas
