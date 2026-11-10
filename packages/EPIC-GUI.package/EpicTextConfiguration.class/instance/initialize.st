initialization
initialize
	super initialize.
	self
		layoutPolicy: TableLayout new;
		beTransparent;
		layoutInset: 10 px;
		cellInset: 10 px;
		listCentering: #topLeft;
		cellPositioning: #center;
		listDirection: #leftToRight;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap