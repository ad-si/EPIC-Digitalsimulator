drawing
drawDINInputPortLinesOn: aCanvas
	self inputPorts do: [:eachPort |
		aCanvas 
			line: eachPort center 
			to: (self gateBoxDIN left + 18 px) @ (eachPort center y)
			width: self lineWidth color: Color black
	]