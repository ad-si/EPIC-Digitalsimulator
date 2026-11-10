drawing
drawANSIOrInputPortsOn: aCanvas
	self inputPorts
		do: [:eachPort | aCanvas
			line: eachPort center
			to: self gateBoxANSI left + 8 px @ eachPort center y
			width: self lineWidth color: Color black].