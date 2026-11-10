method-templates
handleMouseDown: anEvent
	"System level event handling. Copy of Morph>>handleMouseDown: from Squeak 6.1,
	which suppresses the meta menu and routes the blue button to #blueButtonDown:."
	anEvent wasHandled ifTrue:[^self]. "not interested"
	anEvent hand removePendingBalloonFor: self.
	anEvent hand removePendingHaloFor: self.
	anEvent wasHandled: true.
	(anEvent controlKeyPressed and: [ Preferences cmdGesturesEnabled ])
		ifTrue:[^self invokeMetaMenu: anEvent].
	"Make me modal during mouse transitions"
	anEvent hand newMouseFocus: self event: anEvent.
	anEvent blueButtonChanged ifTrue:[^self blueButtonDown: anEvent].
	self mouseDown: anEvent.
	anEvent hand removeHaloFromClick: anEvent on: self.
	(self handlesMouseStillDown: anEvent) ifTrue:[
		self startStepping: #handleMouseStillDown:
			at: Time millisecondClockValue + self mouseStillDownThreshold
			arguments: {anEvent copy resetHandlerFields}
			stepTime: self mouseStillDownStepRate].
