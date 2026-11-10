scaling
scalePoint: aPoint
	"Convert a point from unscaled (100%) coordinates, as stored in circuit files, to screen coordinates at the current UI scale factor."
	^ (aPoint * RealEstateAgent scaleFactor) rounded
