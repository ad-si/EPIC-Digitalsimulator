drawing
drawOn: aCanvas
	| font |
	aCanvas fillRectangle: self bounds color: Color white.
	aCanvas frameRectangle: self bounds width: 1 px color: Color black.
	"The key is a plain Morph, so it cannot use EpicComponent>>#drawString:centeredAt:on:"
	font := TextStyle defaultFont.
	aCanvas
		drawString: self label
		at: self center - (((font widthOfString: self label) @ font height) // 2)
		font: font
		color: Color black