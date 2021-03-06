"Filed out from Dolphin Smalltalk XP"!

RemoveParameterRefactoring subclass: #InlineParameterRefactoring
	instanceVariableNames: 'expressions'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
InlineParameterRefactoring guid: (GUID fromString: '{9E2F3B66-4A50-4DA3-97D8-7B1AF9C59EA5}')!
InlineParameterRefactoring comment: ''!
!InlineParameterRefactoring categoriesForClass!Refactory-Refactorings! !
!InlineParameterRefactoring methodsFor!

allExpressionsToInline
	| coll |
	coll := Set new.
	self model allReferencesTo: oldSelector
		do: 
			[:each | 
			| tree |
			tree := each parseTree.
			tree notNil ifTrue: [coll addAll: (self expressionsToInlineFrom: tree)]].
	^coll asOrderedCollection!

expressionsToInlineFrom: aTree 
	| searcher |
	searcher := ParseTreeSearcher new.
	searcher matches: '``@obj ' , (self buildSelectorString: oldSelector)
		do: 
			[:aNode :answer | 
			answer
				add: (aNode arguments at: parameterIndex);
				yourself].
	^searcher executeTree: aTree initialAnswer: OrderedCollection new!

inlineParameter: aString in: aClass selector: aSelector
	#rbFix. "Ensure the displayString works when the model name is initialized"
	class := aClass.
	oldSelector := aSelector.
	argument := aString.
	class := self classObjectFor: aClass.
!

modifyImplementorParseTree: parseTree in: aClass 
	| node assignment |
	node := (parseTree arguments at: parameterIndex) copy.
	parseTree body addTemporaryNamed: node name.
	assignment := RBAssignmentNode variable: node copy value: expressions first.
	parseTree body addNodeFirst: assignment.
	super modifyImplementorParseTree: parseTree in: aClass!

myConditions
	self getNewSelector.
	expressions := self allExpressionsToInline.
	^(RBCondition definesSelector: oldSelector in: class) 
		& ((RBCondition withBlock: [expressions notEmpty]) 
				errorMacro: 'No callers. Use Remove Method instead.') 
			& ((RBCondition withBlock: [expressions size = 1]) 
					errorMacro: 'All values passed as this argument must be identical.') 
			& ((RBCondition withBlock: [expressions first isLiteralNode]) 
					errorMacro: 'All values passed as this argument must be literal.')!

storeOn: aStream 
	aStream nextPut: $(.
	self class storeOn: aStream.
	aStream
		nextPutAll: ' inlineParameter: ''';
		nextPutAll: argument;
		nextPutAll: ''' in: '.
	class storeOn: aStream.
	aStream
		nextPutAll: ' selector: #';
		nextPutAll: oldSelector;
		nextPut: $)! !
!InlineParameterRefactoring categoriesFor: #allExpressionsToInline!enquiries!private! !
!InlineParameterRefactoring categoriesFor: #expressionsToInlineFrom:!private! !
!InlineParameterRefactoring categoriesFor: #inlineParameter:in:selector:!initialize/release!public! !
!InlineParameterRefactoring categoriesFor: #modifyImplementorParseTree:in:!public!transforming! !
!InlineParameterRefactoring categoriesFor: #myConditions!preconditions!public! !
!InlineParameterRefactoring categoriesFor: #storeOn:!printing!public! !

!InlineParameterRefactoring class methodsFor!

inlineParameter: aString in: aClass selector: aSelector 
	^self new 
		inlineParameter: aString
		in: aClass
		selector: aSelector!

model: aRBNamespace inlineParameter: aString in: aClass selector: aSelector 
	^(self new)
		model: aRBNamespace;
		inlineParameter: aString
			in: aClass
			selector: aSelector;
		yourself! !
!InlineParameterRefactoring class categoriesFor: #inlineParameter:in:selector:!instance creation!public! !
!InlineParameterRefactoring class categoriesFor: #model:inlineParameter:in:selector:!instance creation!public! !

