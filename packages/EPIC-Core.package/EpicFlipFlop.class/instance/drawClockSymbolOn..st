drawing
drawClockSymbolOn: aCanvas

	aCanvas
		 line: (self gateBoxANSI bottomLeft x @ self inputPorts second topRight y)
		 to: (self gateBoxANSI bottomLeft x + 10 px @ self inputPorts second center y)
		 width: self lineWidth color: Color black.
	aCanvas
		 line: (self gateBoxANSI bottomLeft x @ self inputPorts second bottomRight y)
		 to: (self gateBoxANSI bottomLeft x + 10 px @ self inputPorts second center y)
		 width: self lineWidth color: Color black