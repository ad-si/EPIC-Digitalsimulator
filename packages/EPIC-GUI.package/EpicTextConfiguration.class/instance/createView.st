initialization
createView
	| textMorph |
	textMorph := PluggableTextMorph on: self text: #targetValue accept: #targetValue:.
	textMorph
		acceptOnCR: true;
		height: (TextStyle defaultFont height + 6 px);
		vResizing: #rigid;
		hResizing: #shrinkWrap;
		minimumWidth: 10 px;
		layoutInset: 15 px negated.
	
	self
		addMorphBack: (StringMorph contents: self label);
		addMorphBack: textMorph