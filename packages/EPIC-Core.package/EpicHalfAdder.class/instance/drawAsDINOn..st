drawing
drawAsDINOn: aCanvas

	aCanvas 
		fillRectangle: self gateBoxDIN color: self fillColor;
		frameRectangle: self gateBoxDIN width: self lineWidth color: Color black.
	self drawLines: #('1 N1,2' '2 G1,2') centeredAt: self gateBoxDIN center on: aCanvas.
	self drawDINInputPortsOn: aCanvas.
	self drawDINOutputPortsOn: aCanvas.
	self drawDINOutputPortsSecondOn: aCanvas


		

