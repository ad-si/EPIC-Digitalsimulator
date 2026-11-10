drawing
drawANSIAndBaseShapeOn: aCanvas
	| leftBox rightBox |
	leftBox := Rectangle 
				origin: self gateBoxANSI topLeft 
				extent: self gateBoxANSI extent / (2@1). 
	rightBox := Rectangle 
				origin: self gateBoxANSI topCenter 
				extent: self gateBoxANSI extent / (2@1). 
	aCanvas 
		clipBy: (Rectangle
			origin: leftBox origin - ((1@1) * self lineWidth)
			extent: leftBox extent + ((1@2) * self lineWidth))
		during: [ :sameCanvas |
			sameCanvas
				fillRectangle: self gateBoxANSI color: self fillColor;
				frameRectangle: self gateBoxANSI width: self lineWidth color: Color black].
	self fillFrameRightArc: rightBox diameter: self gateBoxANSI extent on: aCanvas