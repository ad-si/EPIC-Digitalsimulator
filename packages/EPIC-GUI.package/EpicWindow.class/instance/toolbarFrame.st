geometry
toolbarFrame
	"Frame for the PrototypePanel.
	Extends to the lower border. Offset for the menu bar."
	^ LayoutFrame
		fractions: (0@0 corner: 0@1)
		offsets: (0 @ self class menuBarHeight corner: (self class prototypeFrameWidth)@0)