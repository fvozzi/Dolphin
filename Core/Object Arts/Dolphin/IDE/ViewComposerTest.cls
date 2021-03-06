"Filed out from Dolphin Smalltalk 7"!

DolphinTest subclass: #ViewComposerTest
	instanceVariableNames: 'vc testClass'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ViewComposerTest guid: (GUID fromString: '{84C0E504-BDDA-4D87-92DC-53B89F80F634}')!
ViewComposerTest comment: ''!
!ViewComposerTest categoriesForClass!Unclassified! !
!ViewComposerTest methodsFor!

dragResourceFor: resourceName operation: op 
	| session toolbox |
	toolbox := vc instVarNamed: 'toolboxPresenter'.
	session := InternalDragDropSession dragSource: toolbox view
				item: (ResourceIdentifier class: resourceName).
	toolbox resourcesPresenter onDragResource: session.
	session
		startTrackingAt: 20 @ 20;
		operation: op.
	^session!

getButtonResource
	^(ResourceIdentifier class: PushButton name: 'Push button') resource!

getContainerResource
	^(ResourceIdentifier class: ContainerView) resource!

getShellResource
	^(ResourceIdentifier class: Shell) resource!

getStaticTextResource
	^(ResourceIdentifier class: TextPresenter name: 'Static text') resource!

setUp
	vc := ViewComposer show.
	testClass := ViewComposerTest 
				subclass: #ViewComposerTestSample
				instanceVariableNames: ''
				classVariableNames: ''
				poolDictionaries: ''
				classInstanceVariableNames: ''!

tearDown
	testClass removeFromSystem.
	^vc destroy!

testBasicEdit
	| sampleResourceIdentifier |
	self assert: vc caption = 'View Composer'.
	"Test loading a default shell"
	vc newShellView.
	self assert: vc composingView class == ShellView.
	self assert: vc primarySelection = vc composingView.
	"Test closing"
	vc viewCloseNoPrompt.
	self assert: vc composingView isNil.
	self assert: vc hasComposingView not.
	self assert: vc caption = 'View Composer'.
	self assert: vc viewHierarchyPresenter model isEmpty.
	"Test open on something more complex"
	vc openOn: (ResourceIdentifier class: SystemBrowserShell).
	"Test saving"
	sampleResourceIdentifier := ResourceIdentifier class: testClass.
	vc resourceIdentifier: sampleResourceIdentifier.
	vc viewSave.
	self assert: (testClass class includesSelector: #resource_Default_view).
	vc viewCloseNoPrompt.
	self assert: vc composingView isNil.

	"Test we can reload what we saved"
	vc openOn: sampleResourceIdentifier.
	self assert: vc composingView class == ShellView.
	self assert: vc primarySelection = vc composingView.
	vc viewCloseNoPrompt!

testCutCopyPaste
	| shell container button |
	vc newShellView.
	shell := vc composingView.
	container := vc 
				pasteResource: self getContainerResource
				context: shell
				position: 0 @ 0.
	self assert: container class = ContainerView.
	container name: 'container'.
	button := vc 
				pasteResource: self getButtonResource
				context: container
				position: 0 @ 0.
	self assert: button class = PushButton.
	button name: 'button'.
	vc selection: button.
	vc copySelection.
	vc selection: shell.
	vc pasteClipboard.
	"Check new button exists in shell"
	self assert: vc primarySelection class == PushButton.
	self assert: vc primarySelection parentView == shell.
	self assert: vc primarySelection ~~ button.
	"Check old button still exists"
	self assert: button isOpen.
	self assert: button parentView == container.
	"Now try cut"
	vc selection: button.
	vc cutSelection.
	vc selection: shell.
	vc pasteClipboard.
	"Check new button exists in shell"
	self assert: vc primarySelection class == PushButton.
	self assert: vc primarySelection parentView == shell.
	self assert: vc primarySelection ~~ button.
	"Check old button has gone"
	self assert: button isOpen not.
	self assert: button parentView ~~ container!

testDragResourceOverEmptyArena
	| session |
	vc onDragOverArena: (session := self dragResourceFor: Shell operation: #copy).
	self assert: session operation == #copy.
	self assert: session suggestedTarget == vc arena.
!

testDropResourceLinkOverShell
	"Drop a Checkbox link onto a shell"

	vc newShellView.
	vc onDropOverArena: (self dragResourceFor: TextPresenter operation: #link).
	self assert: (vc primarySelection isKindOf: ReferenceView).
	self assert: vc primarySelection resourceIdentifier = (ResourceIdentifier class: TextPresenter)!

testDropResourceOverEmptyArena
	"Drop a shell onto an empty arena"

	vc onDropOverArena: (self dragResourceFor: Shell operation: #copy).
	self assert: (vc composingView isKindOf: ShellView)!

testDropResourceOverHierarchy
	"Drop a Checkbox onto a shell"

	| session |
	vc newShellView.
	session := self dragResourceFor: TextPresenter operation: #copy.
	session suggestedTarget: vc viewHierarchyPresenter model roots first.
	vc onDropOverHierarchy: session.
	self assert: (vc primarySelection isKindOf: TextEdit)!

testDropResourceOverShell
	"Drop a Checkbox onto a shell"

	vc newShellView.
	vc onDropOverArena: (self dragResourceFor: TextPresenter operation: #copy).
	self assert: (vc primarySelection isKindOf: TextEdit)!

testIgnoreShellPreferredExtent
	"Check to make sure that the VC doesn't allow the choice of shell extents
	even when they are marked as #userPreferredExtent"

	vc openOn: (ResourceIdentifier class: Shell).
	self assert: vc composingView usePreferredExtent.
	"If this test fails check to see that ShellView>>resourcce_Default_view does indeed have an
	extent of 600@400 when saved by the VC"
	self assert: vc composingView extent = (600 @ 400)!

testNoDragResourceOverInUseArena
	| session toolbox |
	vc newShellView.
	toolbox := vc instVarNamed: 'toolboxPresenter'.
	session := InternalDragDropSession dragSource: toolbox view
				item: (ResourceIdentifier class: Shell).
	toolbox resourcesPresenter onDragResource: session.
	session
		startTrackingAt: 20 @ 20;
		operation: #copy.
	vc onDragOverArena: session.
	self assert: session operation isNil.
	self assert: session suggestedTarget isNil!

testPasteToArena
	"Get a ShellView to paste"

	| shell button |
	vc newShellView.
	shell := vc composingView.
	vc copySelection.
	vc viewCloseNoPrompt .
	"Paste to empty view composer"
	self assert: vc canPaste.
	vc pasteClipboard.
	shell := vc primarySelection.
	self assert: shell class = ShellView.
	"Get a PushButton to paste"
	button := vc 
				pasteResource: self getButtonResource
				context: shell
				position: 0 @ 0.
	vc selection: button.
	vc copySelection.
	vc viewCloseNoPrompt .
	"Paste to empty view composer"
	vc pasteClipboard.
	"Check new button exists"
	self assert: vc primarySelection class == PushButton.
	self assert: vc primarySelection parentView == View desktop.
	vc viewCloseNoPrompt!

testWidenSelection
	| chb classTree |
	vc openOn: (ResourceIdentifier class: ClassBrowserShell name: 'Default view').
	chb := vc composingView.
	classTree := chb viewNamed: 'classes'.
	vc selection: classTree.
	self assert: vc primarySelection == classTree.
	vc widenSelection.
	self assert: vc primarySelection == classTree parentView.
	vc widenSelection.
	self assert: vc primarySelection == classTree parentView parentView.
	vc widenSelection.
	self assert: vc primarySelection == chb.
	vc widenSelection.
	self assert: vc primarySelection == chb!

testZOrderPreservedByMutate
	| shell |
	vc newShellView.
	shell := vc pasteContext.
	1 to: 3
		do: 
			[:i | 
			| view |
			view := vc 
						pasteResource: (ResourceIdentifier class: TextPresenter name: 'Default view') resource
						context: shell
						position: (20 * i) @ (10 * i).
			view name: i printString].
	self assert: (shell subViews collect: [:each | each name]) asArray = #('1' '2' '3').
	vc selection: shell.
	vc mutateTo: ContainerView.
	self assert: (shell subViews collect: [:each | each name]) asArray = #('1' '2' '3')! !
!ViewComposerTest categoriesFor: #dragResourceFor:operation:!private!unit tests! !
!ViewComposerTest categoriesFor: #getButtonResource!private!unit tests! !
!ViewComposerTest categoriesFor: #getContainerResource!private!unit tests! !
!ViewComposerTest categoriesFor: #getShellResource!private!unit tests! !
!ViewComposerTest categoriesFor: #getStaticTextResource!private!unit tests! !
!ViewComposerTest categoriesFor: #setUp!private!unit tests! !
!ViewComposerTest categoriesFor: #tearDown!private!unit tests! !
!ViewComposerTest categoriesFor: #testBasicEdit!public!unit tests! !
!ViewComposerTest categoriesFor: #testCutCopyPaste!public!unit tests! !
!ViewComposerTest categoriesFor: #testDragResourceOverEmptyArena!public!unit tests! !
!ViewComposerTest categoriesFor: #testDropResourceLinkOverShell!public!unit tests! !
!ViewComposerTest categoriesFor: #testDropResourceOverEmptyArena!public!unit tests! !
!ViewComposerTest categoriesFor: #testDropResourceOverHierarchy!public!unit tests! !
!ViewComposerTest categoriesFor: #testDropResourceOverShell!public!unit tests! !
!ViewComposerTest categoriesFor: #testIgnoreShellPreferredExtent!public!unit tests! !
!ViewComposerTest categoriesFor: #testNoDragResourceOverInUseArena!public!unit tests! !
!ViewComposerTest categoriesFor: #testPasteToArena!public!unit tests! !
!ViewComposerTest categoriesFor: #testWidenSelection!public!unit tests! !
!ViewComposerTest categoriesFor: #testZOrderPreservedByMutate!public!unit tests! !

