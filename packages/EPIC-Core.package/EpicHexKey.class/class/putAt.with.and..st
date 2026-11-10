initialize
putAt: aPosition with: label and: value
	| instance |
	instance := self new.
	instance label: label.
	instance value: value.
	instance extent: EpicHexKeyboard keyWidth asPoint.
	instance center: aPosition.
	^instance 