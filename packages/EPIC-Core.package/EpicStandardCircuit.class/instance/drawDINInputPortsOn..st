drawing
drawDINInputPortsOn: aCanvas

	self inputPorts do: [:eachPort |
		aCanvas 
			line: eachPort center 
			to: (self gateBoxDIN left) @ (eachPort center y)
			width: self lineWidth color: Color black]