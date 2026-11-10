drawing
drawANSINotCircleOn: aCanvas
	aCanvas 
		fillOval: self notDotANSI color: self fillColor;
		frameOval:  self notDotANSI width: self lineWidth color: Color black.
	aCanvas 
		line: self outputPorts first center 
		to: (self notDotANSI right) @ (self outputPorts first center y)
		width: self lineWidth color: Color black