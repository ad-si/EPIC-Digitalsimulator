drawing
drawANSIInputPortsOn: aCanvas

		self inputPorts do: [:eachPort |
		aCanvas 
			line: eachPort center 
			to: (self gateBoxANSI left) @ (eachPort center y)
			width: self lineWidth color: Color black]
