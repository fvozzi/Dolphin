"Filed out from Dolphin Smalltalk 7"!

SmalltalkWorkspace subclass: #ValueWorkspace
	instanceVariableNames: 'textModel'
	classVariableNames: 'ValueIsSelfCookie'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ValueWorkspace guid: (GUID fromString: '{87B4C6C9-026E-11D3-9FD7-00A0CC3E4A32}')!
ValueWorkspace comment: 'ValueWorkspace is a <valuePresenter> for displaying the contents of a <valueModel> using a <ScintillaView>. ValueWorkspace allows Smalltalk expressions to be entered and, when Accepted,  the result of the evaluation is stored back to the model. ValueWorkspace is used as a fundamental part of the PublishedAspectInspector.

Note that this is a somewhat unusual MVP triad; the ValueWorkspace model is not connected directly to the view. Instead, the view is redirected (via #viewModel) to another model that holds the textual rendition of the actual model.

Instance Variables:
	textModel		<ValueHolder> holding the textual rendition of the model''s value.

'!
!ValueWorkspace categoriesForClass!Development!MVP-Presenters! !
!ValueWorkspace methodsFor!

accept
	"Accept changes to the receiver by evaluating it, and setting the result into the associated
	model. If there is no selection, then the entire contents of the workspace are accepted."

	| evaluation |
	self displayValue isEmpty 
		ifTrue: 
			["If we have no contents justr leave well alone"
			^true].
	self view hasSelection 
		ifFalse: 
			["We assume that the whole text is to be evaluated. In this case, if the
			 text has not been changed we can ignore the accept and answer true. This
			 will allow the user to just hit enter on some store strings that don't
			 compile."
			self view isModified ifFalse: [^true].
			self view selectAll].
	evaluation := 
			[self evaluateItIfFail: 
					[self showCompileErrorBubble: errorModel value.
					^false]] 
					on: Error
					do: 
						[:x | 
						self showEvaluationErrorBubble: x.
						^false].
	self value: evaluation.
	^true!

beSingleLineMode
	"Set the receiver into single line mode"

	(self view)
		wantReturn: false;
		selectAll!

displayValue
	| value |
	value := self value.
	^[value printString] on: Error
		do: 
			[:ex | 
			self unableToDisplayVariableErrorFormatString 
				expandMacrosWith: 'self'
				with: value class
				with: ex description]!

errorBubbleTimeout
	^2000!

errorLocation
	"Answers the screen coordnates of where the error can be found. Typically this is the base of the caret location in our associated view"

	^self view caretScreenCoordinates + (0 @ self view actualFont pixelSize)!

evaluationContext
	"Answers the evaluation context for this workspace which is in fact the model's value"

	| ctx |
	ctx := super evaluationContext.
	^ctx == ValueIsSelfCookie ifTrue: [self value] ifFalse: [ctx]!

initialize
	"Private - Initialize the receiver's instance variables."

	super initialize.
	textModel := String new asValue.
	self evaluationContext: ValueIsSelfCookie!

isSingleLineMode
	"Answer true if the receiver will only manage a single line of text"

	^self view wantReturn not!

model: aValueModel 
	"Set the model of the receiver to be a value model on anObject."

	super model: aValueModel.
	aValueModel 
		when: #valueChanged
		send: #onValueChanged
		to: self.
	self onValueChanged!

onValueChanged
	"Private - The receiver's model has changed. Transfer the text representation of the new value to the
	textModel"

	textModel value: self displayValue!

queryCommand: aCommandQuery 
	"Private - Enters details about a potential command for the receiver into the <CommandQuery>
	argument."

	| cmd |
	cmd := aCommandQuery commandSymbol.
	cmd == #accept 
		ifTrue: 
			[aCommandQuery isEnabled: self model canSet.
			^true].
	^super queryCommand: aCommandQuery!

showCompileErrorBubble: anError 
	self showErrorBubble: anError displayString caption: 'Syntax error'!

showErrorBubble: message caption: caption 
	(MessageBubble new)
		font: (Font name: 'Arial' pointSize: 10);
		timeout: self errorBubbleTimeout;
		isCentered: true;
		position: self errorLocation;
		caption: caption;
		errorMsg: message!

showEvaluationErrorBubble: anError 
	self showErrorBubble: anError displayString caption: 'Evaluation error'!

unableToDisplayVariableErrorFormatString
	"Private - Answer the format string used to construct the error message text to be displayed
	in place of a variable value when a variable is selected that cannot be printed."

	^'an invalid <2p> [<3s>]<n><n>Evaluate the following expression to debug:<n><t>self printString'!

value
	"Answer the model value of the receiver. Any view changes may first need to be flushed"

	self view notNil ifTrue: [self view updateModel].
	^self model value!

value: anObject
	"Set the model value of the receiver to be anObject"

	self model value: anObject.
!

viewModel
	"Private - Answer the model that is to be connected to the view. It is actually
	connected to the receiver's textModel - not the receiver's value model"

	^textModel! !
!ValueWorkspace categoriesFor: #accept!commands!public! !
!ValueWorkspace categoriesFor: #beSingleLineMode!public! !
!ValueWorkspace categoriesFor: #displayValue!accessing!private! !
!ValueWorkspace categoriesFor: #errorBubbleTimeout!constants!private! !
!ValueWorkspace categoriesFor: #errorLocation!private! !
!ValueWorkspace categoriesFor: #evaluationContext!accessing!public! !
!ValueWorkspace categoriesFor: #initialize!initializing!private! !
!ValueWorkspace categoriesFor: #isSingleLineMode!public! !
!ValueWorkspace categoriesFor: #model:!accessing!public! !
!ValueWorkspace categoriesFor: #onValueChanged!event handling!private! !
!ValueWorkspace categoriesFor: #queryCommand:!commands!private! !
!ValueWorkspace categoriesFor: #showCompileErrorBubble:!private! !
!ValueWorkspace categoriesFor: #showErrorBubble:caption:!private! !
!ValueWorkspace categoriesFor: #showEvaluationErrorBubble:!private! !
!ValueWorkspace categoriesFor: #unableToDisplayVariableErrorFormatString!constants!private! !
!ValueWorkspace categoriesFor: #value!accessing!public! !
!ValueWorkspace categoriesFor: #value:!accessing!public! !
!ValueWorkspace categoriesFor: #viewModel!accessing!private! !

ValueWorkspace methodProtocol: #valuePresenter attributes: #(#readOnly) selectors: #(#value #value:)!

!ValueWorkspace class methodsFor!

defaultModel
	"Answer a default model to be assigned to the receiver when it
	is initialized."

	^nil asValue!

initialize
	"Private - Initialize the receiver's class variables.
		self initialize
	"

	ValueIsSelfCookie := (Object new)
				isImmutable: true;
				yourself!

resource_Default_view
	"Answer the literal data from which the 'Default view' resource can be reconstituted.
	DO NOT EDIT OR RECATEGORIZE THIS METHOD.

	If you wish to modify this resource evaluate:
	ViewComposer openOn: (ResourceIdentifier class: self selector: #resource_Default_view)
	"

	^#(#'!!STL' 3 788558 10 ##(Smalltalk.STBViewProxy) 8 ##(Smalltalk.ScintillaView) 98 50 0 0 98 2 8 1411453252 1 416 721990 2 ##(Smalltalk.ValueHolder) 0 32 1310726 ##(Smalltalk.EqualitySearchPolicy) 0 524550 ##(Smalltalk.ColorRef) 8 4278190080 0 21 265030 4 ##(Smalltalk.Menu) 0 16 98 17 984134 2 ##(Smalltalk.CommandMenuItem) 1 1180998 4 ##(Smalltalk.CommandDescription) 8 #accept 8 '&Accept' 1 1 0 0 0 983366 1 ##(Smalltalk.DividerMenuItem) 4097 610 0 16 98 9 658 1 690 8 #undo 8 '&Undo' 1 1 263494 3 ##(Smalltalk.Icon) 0 16 1572870 ##(Smalltalk.ImageRelativeFileLocator) 8 'EditUndo.ico' 2032142 ##(Smalltalk.STBExternalResourceLibraryProxy) 8 'dolphindr7.dll' 0 0 0 754 4097 658 1 690 8 #cutSelection 8 'Cu&t' 1 1 882 0 16 928 8 'EditCut.ico' 976 0 0 658 1 690 8 #copySelection 8 '&Copy' 1 1 882 0 16 928 8 'EditCopy.ico' 976 0 0 658 1 690 8 #pasteClipboard 8 '&Paste' 1 1 882 0 16 928 8 'EditPaste.ico' 976 0 0 658 1 690 8 #clearSelection 8 'De&lete' 1 1 882 0 16 928 8 'EditClear.ico' 976 0 0 658 1 690 8 #reformatSource 8 'Re&format' 1 1 0 0 0 754 4097 658 1 690 8 #selectAll 8 '&Select All' 1 1 0 0 0 8 '&Edit' 0 134217729 0 0 0 0 0 658 1 690 8 #clear 8 'Clea&r' 1 1 0 0 0 754 4097 658 1 690 8 #browseIt 8 'Bro&wse It' 1 1 882 0 16 928 8 'ClassBrowserShell.ico' 976 0 0 658 1 690 8 #displayIt 8 '&Display It' 1 1 882 0 16 928 8 'DisplayIt.ico' 976 0 0 658 1 690 8 #evaluateIt 8 'E&valuate It' 1 1 882 0 16 928 8 'EvaluateIt.ico' 976 0 0 658 1 690 8 #inspectIt 8 '&Inspect It' 1 1 882 0 16 928 8 'InspectIt.ico' 976 0 0 658 1 690 8 #debugIt 8 'Deb&ug It' 1 1 882 0 16 928 8 'Debugger.ico' 976 0 0 754 4097 658 1 690 8 #chooseEvaluationPools 8 '&Pools...' 1 1 882 0 16 928 8 'SystemDictionary.ico' 976 0 0 658 1 690 8 #inspectWorkspacePool 8 'Variab&les' 1 1 0 0 0 754 4097 610 0 16 98 2 658 2097153 690 8 #browseDefinitions 8 'Defi&nitions...' 1 1 0 0 0 658 1 690 8 #browseReferences 8 '&References...' 1 1 0 0 0 8 '&Browse' 0 1 0 0 0 0 0 754 4097 610 0 16 98 9 658 1 690 8 #toggleAutoCompletion 8 '&Auto-complete' 1 1 0 0 0 658 1 690 8 #toggleIndentationGuides 8 'Indentation &Guides' 1 1 0 0 0 658 1 690 8 #toggleLineEndings 8 'Line &Endings' 1 1 0 0 0 658 1 690 8 #toggleLineNumbers 8 'Line N&umbers' 1 1 0 0 0 658 1 690 8 #toggleStyling 8 '&Syntax Coloring' 1 1 0 0 0 658 1 690 8 #toggleWhitespace 8 'W&hitespace' 1 1 0 0 0 658 1 690 8 #toggleWordWrap 8 '&Word Wrap' 1 1 0 0 0 754 4097 610 0 16 98 2 658 1 690 459270 ##(Smalltalk.Message) 8 #language: 98 1 8 #container 8 '&Smalltalk' 1 1 0 0 0 658 1 690 3074 3104 98 1 8 #xml 8 '&Xml' 1 1 0 0 0 8 '&Language' 0 134217729 0 0 0 0 0 8 '&Options' 0 134217729 0 0 0 0 0 8 '&Workspace' 0 134217729 0 0 0 0 0 0 0 416 0 8 4294907501 852486 ##(Smalltalk.NullConverter) 0 0 9 0 234 256 98 4 8 #callTip 1182790 1 ##(Smalltalk.ScintillaTextStyle) 77 786694 ##(Smalltalk.IndexedColor) 33554457 3442 33554471 1 0 0 0 0 3392 0 0 0 8 #normal 3410 1 0 0 1 0 0 0 0 3488 0 0 0 98 40 3504 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1639686 ##(Smalltalk.SmalltalkExpressionStyler) 1 0 0 32 202 208 98 0 234 256 98 2 8 #default 1641542 1 ##(Smalltalk.ScintillaMarkerDefinition) 1 0 0 0 416 8 #circle 0 0 0 0 0 0 202 208 3584 0 63 9215 0 0 0 0 3442 33554447 0 0 65 0 0 234 256 98 6 8 #specialCharacter 8 '()[]<>' 8 #literalBytes 8 '[]' 8 #literalArray 8 '()' 8 '' 3 234 256 98 2 3136 3360 0 0 0 0 3 0 234 256 3584 0 0 234 256 98 6 8 #Notification 3410 1029 0 196934 1 ##(Smalltalk.RGB) 31185883 1 0 0 0 0 3952 0 0 0 8 #Error 3410 1031 3986 335 3986 31317503 1 0 0 0 0 4016 0 0 0 8 #Warning 3410 1027 3986 60239 3986 31326207 1 0 0 0 0 4080 0 0 0 0 983302 ##(Smalltalk.MessageSequence) 202 208 98 13 721670 ##(Smalltalk.MessageSend) 8 #createAt:extent: 98 2 328198 ##(Smalltalk.Point) 3839 21 4274 501 41 416 4210 8 #contextMenu: 98 1 624 416 4210 8 #selectionRange: 98 1 525062 ##(Smalltalk.Interval) 3 1 3 416 4210 8 #isTextModified: 98 1 32 416 4210 8 #modificationEventMask: 98 1 9215 416 4210 8 #hoverTime: 98 1 1001 416 4210 8 #secondaryCaretForecolor: 98 1 3986 16711423 416 4210 8 #caretPeriod: 98 1 1061 416 4210 8 #wordWrap: 98 1 16 416 4210 8 #margins: 98 1 98 3 984902 1 ##(Smalltalk.ScintillaMargin) 1 416 1 3 32 1 5 4818 3 416 1 1 32 67108863 5 4818 5 416 1 1 32 1 5 416 4210 8 #tabIndents: 98 1 16 416 4210 8 #tabWidth: 98 1 9 416 4210 8 #areAdditionalCaretsVisible: 98 1 16 416 983302 ##(Smalltalk.WINDOWPLACEMENT) 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 127 7 0 0 10 0 0 0 121 8 0 0 30 0 0 0] 98 0 4274 193 193 0 29 )! !
!ValueWorkspace class categoriesFor: #defaultModel!models!public! !
!ValueWorkspace class categoriesFor: #initialize!initializing!private! !
!ValueWorkspace class categoriesFor: #resource_Default_view!public!resources-views! !

