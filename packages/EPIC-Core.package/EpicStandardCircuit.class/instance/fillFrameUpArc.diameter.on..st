as yet unclassified
fillFrameUpArc: aRectangle diameter: aDiameter on: aCanvas
	| clipBox oval |
	clipBox := Rectangle
		origin: aRectangle origin + ((-1 @ -1) * self lineWidth)
		extent: aRectangle extent + ((2 @ 1) * self lineWidth).
	oval := Rectangle origin: aRectangle origin extent: aDiameter.
	self fillFrameOval: oval clipBy: clipBox on: aCanvas