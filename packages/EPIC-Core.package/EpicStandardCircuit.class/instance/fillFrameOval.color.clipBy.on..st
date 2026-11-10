as yet unclassified
fillFrameOval: aRectangle color: aColor clipBy: aClipBox on: aCanvas
	aCanvas clipBy: aClipBox during: [ :sameCanvas |
			sameCanvas fillOval: aRectangle color: aColor borderWidth: self lineWidth borderColor: Color black ]