drawing
drawDINOutputPortsOn: aCanvas
	
	aCanvas 
		line: self outputPorts first center 
		to: (self gateBoxDIN right) @ (self outputPorts first center y)
		width: self lineWidth color: Color black