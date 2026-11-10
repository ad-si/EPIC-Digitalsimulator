drawing
drawPolyLine: aCollectionOfPoints on: aCanvas
	aCollectionOfPoints overlappingPairsDo: [:startPoint :endPoint |
		aCanvas 
			line: startPoint
			to: endPoint
			width: self lineWidth color: Color black
	]
