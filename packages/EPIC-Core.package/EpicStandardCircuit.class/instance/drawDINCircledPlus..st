drawing
drawDINCircledPlus: aCanvas
	aCanvas
		line: self gateBoxDIN center - (3 px @ 0)
		to: self gateBoxDIN center + (3 px @ 0)
		width: self lineWidth color: Color black.
	aCanvas
		line: self gateBoxDIN center - (0 @ 3 px)
		to: self gateBoxDIN center + (0 @ 3 px)
		width: self lineWidth color: Color black.
	aCanvas
		frameOval: (Rectangle center: self gateBoxDIN center extent: 11 px asPoint)
		width: self lineWidth color: Color black