drawing
drawIECOutputPortsSecondOn: aCanvas
	
		aCanvas 
		line: self outputPorts second center 
		to: (self gateBoxIEC right) @ (self outputPorts second center y)
		width: self lineWidth color: Color black.