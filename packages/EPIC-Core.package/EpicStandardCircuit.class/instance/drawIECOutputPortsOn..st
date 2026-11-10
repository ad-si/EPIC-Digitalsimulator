drawing
drawIECOutputPortsOn: aCanvas
	
	aCanvas 
		line: self outputPorts first center 
		to: (self gateBoxIEC right) @ (self outputPorts first center y)
		width: self lineWidth color: Color black