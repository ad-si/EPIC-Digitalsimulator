drawing
connectOutputPortsOn: aCanvas

	self outputPorts do: [:eachPort |
		aCanvas 
			line: eachPort center 
			to: (self gateBoxANSI right) @ (eachPort center y)
			width: self lineWidth color: Color black]
