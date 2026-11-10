drawing
drawLines: aCollectionOfStrings centeredAt: aPoint on: aCanvas
	"Draw the lines of text below each other, each one centered horizontally, and the whole block centered vertically on aPoint. Uses the actual font metrics, so the text stays centered at any UI scale factor."
	| font top |
	font := TextStyle defaultFont.
	top := aPoint y - (aCollectionOfStrings size * font height // 2).
	aCollectionOfStrings doWithIndex: [:eachLine :index |
		aCanvas
			drawString: eachLine
			at: (aPoint x - ((font widthOfString: eachLine) // 2)) @ (top + (index - 1 * font height))
			font: font
			color: Color black]
