drawing
drawPolygon: aPolygon on: aCanvas
	aCanvas 
		drawPolygon: aPolygon vertices
		color: self fillColor
		borderWidth: self lineWidth 
		borderColor: Color black