"Filed out from Dolphin Smalltalk X6"!

SharedIdentityDictionary variableSubclass: #EventsCollection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
EventsCollection guid: (GUID fromString: '{87B4C533-026E-11D3-9FD7-00A0CC3E4A32}')!
EventsCollection comment: ''!
!EventsCollection categoriesForClass!Collections-Unordered!System-Support! !
!EventsCollection methodsFor!

addEvent: aSymbol action: aValuable 
	"Private - Adds the <valuable> argument as the action for 
	aSymbol, but only if it is not already present."

	mutex critical: 
			[| messages |
			messages := self at: aSymbol ifAbsent: [EventMessageSequence new].
			"Check for existing registration"
			(messages includes: aValuable) 
				ifFalse: 
					[messages add: aValuable.
					self at: aSymbol put: messages]]!

asMinimumRepresentation
	"Private - Answers nil if the receiver is empty, otherwise self."

	^self notEmpty ifTrue: [self]!

hasActionsForEvent: aSymbol 
	^mutex critical: [(self at: aSymbol ifAbsent: [#()]) notEmpty]!

removeActionsForEvent: aSymbol 
	^mutex critical: [self removeKey: aSymbol ifAbsent: []]!

removeEventsTriggeredFor: anObject 
	"Private - Removes all events where the target is anObject. If the receiver becomes empty,
	answers nil, otherwise answers self."

	^mutex critical: 
			[| empty |
			empty := IdentitySet new.
			self keysAndValuesDo: 
					[:eachKey :eachValue | 
					eachValue isNil 
						ifFalse: 
							[eachValue removeMessagesFor: anObject.
							eachValue isEmpty ifTrue: [empty add: eachKey]]].
			self removeAllKeys: empty.
			self asMinimumRepresentation]!

shrink
	"Private - Removes all empty message sequences."

	mutex critical: 
			[| empty |
			empty := IdentitySet new.
			self 
				keysAndValuesDo: [:eachKey :eachValue | (eachValue isNil or: [eachValue isEmpty]) ifTrue: [empty add: eachKey]].
			self removeAllKeys: empty]!

triggerEvent: anEventSymbol
	"Private - Evaluate the sequence of MessageSends registered for the event, 
	anEventSymbol.  Answer the result of the last evaluation, or nil if none."

	^(self at: anEventSymbol ifAbsent: [[]]) value
!

triggerEvent: aSymbol with: anObject 
	"Private - Evaluate the sequence of MessageSends registered for the event named by
	the <Symbol> argument, with a single argument, anObject..
	 Answer the result of the last evaluation, or nil if none."

	^(self at: aSymbol ifAbsent: [[:arg | nil]]) valueWithArguments: (Array with: anObject)!

triggerEvent: aSymbol with: anObject with: anotherObject 
	"Private - Evaluate the sequence of MessageSends registered for the event named by
	the <Symbol> argument, with the pair of arguments, anObject, and, anotherObject.
	 Answer the result of the last evaluation, or nil if none."

	^(self at: aSymbol ifAbsent: [[:arg1 :arg2 | nil]]) 
		valueWithArguments: (Array with: anObject with: anotherObject)!

triggerEvent: aSymbol withArguments: anArray
	"Private - Evaluate the sequence of MessageSends registered for the event named by
	the <Symbol> argument, with the <Array> of arguments, anArray.
	with the specified arguments. Answer the result of the last evaluation, or nil if none."

	^(self at: aSymbol ifAbsent: [^nil]) valueWithArguments: anArray! !
!EventsCollection categoriesFor: #addEvent:action:!adding!private! !
!EventsCollection categoriesFor: #asMinimumRepresentation!converting!private! !
!EventsCollection categoriesFor: #hasActionsForEvent:!private!testing! !
!EventsCollection categoriesFor: #removeActionsForEvent:!adding!private! !
!EventsCollection categoriesFor: #removeEventsTriggeredFor:!private!removing! !
!EventsCollection categoriesFor: #shrink!private!removing! !
!EventsCollection categoriesFor: #triggerEvent:!debugger-step through!private!triggering! !
!EventsCollection categoriesFor: #triggerEvent:with:!debugger-step through!private!triggering! !
!EventsCollection categoriesFor: #triggerEvent:with:with:!debugger-step through!private!triggering! !
!EventsCollection categoriesFor: #triggerEvent:withArguments:!debugger-step through!private!triggering! !

