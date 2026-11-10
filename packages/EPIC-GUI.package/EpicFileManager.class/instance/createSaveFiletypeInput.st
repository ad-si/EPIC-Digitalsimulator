ui creation
createSaveFiletypeInput
	filetypeInput := ((SimpleButtonMorph new)
		label: self filetypeSelectors keys first;
		color: Color white;
		borderWidth: 1 px;
		target: self;
		actionSelector: #openFiletypeSelection).
	^filetypeInput