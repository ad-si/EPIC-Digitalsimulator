drawing
drawClockSymbolOn: aCanvas

	aCanvas
		 line: (self gateBoxANSI bottomLeft x @ self inputPorts fifth topRight y)
		 to: (self gateBoxANSI bottomLeft x + 10 px @ self inputPorts fifth center y)
		 width: self lineWidth color: Color black.
	aCanvas
		 line: (self gateBoxANSI bottomLeft x @ self inputPorts fifth bottomRight y)
		 to: (self gateBoxANSI bottomLeft x + 10 px @ self inputPorts fifth center y)
		 width: self lineWidth color: Color black