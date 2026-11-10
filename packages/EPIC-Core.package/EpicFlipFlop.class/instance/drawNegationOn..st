drawing
drawNegationOn: aCanvas

	aCanvas
		line: (self gateBoxANSI bottomRight x - 3 px @ self outputPorts second topLeft y)
		to: (self gateBoxANSI bottomRight x - 12 px @ self outputPorts second topLeft y)
		width: self lineWidth color: Color black