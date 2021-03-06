"Filed out from Dolphin Smalltalk X6.1"!

ChunkBrowserSeriesChunk subclass: #ChunkBrowserMethodDefineChunk
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ChunkBrowserMethodDefineChunk guid: (GUID fromString: '{1F404FDA-A397-4D69-B6AF-F3BC30E06DF4}')!
ChunkBrowserMethodDefineChunk comment: 'See [DolphinImageFolder]/Idb/Documentation for details

(C) 2006 Ian Bartholomew
ian@idb.me.uk
Public Domain Freeware'!
!ChunkBrowserMethodDefineChunk categoriesForClass!IDB Goodies! !
!ChunkBrowserMethodDefineChunk methodsFor!

browseTarget
	^self identity1AndIdentity2AsCompiledMethod!

canShowDifferences
	^self identity1AndIdentity2AsCompiledMethod notNil!

initializeFromSeriesStart: aChunkBrowserSeriesStartChunk
	super initializeFromSeriesStart: aChunkBrowserSeriesStartChunk.
	identity2 := SelectorParser parse: rawText!

isMatch
	"Answers nil if no comparison is possible, true if the current image matches the chunk and
	false if it doesn't. If the source code is not identical then it has the option of a further
	test for equality using a parse tree"

	| compiledMethod currentTree chunkTree |
	compiledMethod := self identity1AndIdentity2AsCompiledMethod.
	compiledMethod
		ifNil:
			["unable to compare as method not available"
			^nil].
	compiledMethod getSource = rawText
		ifTrue:
			["chunk source is the same as image so must match"
			^true].
	ChunkBrowser compareMethodsUsingParser
		ifFalse:
			["don't want to compare using parser and the sources differs"
			^false].
	(currentTree := compiledMethod parseTreeNoError)
		ifNil:
			["failed to parse current and sources differs"
			^false].
	(chunkTree := SmalltalkParser parseMethod: rawText in: self identity1AsClass)
		ifNil:
			["failed to parse chunk and source differs"
			^false].
	^currentTree = chunkTree!

restore
	"Answers nil or the error information"

	self identity1AsClass
		ifNil: [^index -> 'Target class missing']
		ifNotNil:
			[:arg | 
			| answer |
			[arg compile: self rawText]
				on: CompilerNotification
				do:
					[:e | 
					answer := index -> e errorMessage.
					e resume].
			^answer]!

sourceFromImage
	^self identity1AndIdentity2AsCompiledMethod getSource! !
!ChunkBrowserMethodDefineChunk categoriesFor: #browseTarget!operations!public! !
!ChunkBrowserMethodDefineChunk categoriesFor: #canShowDifferences!public!testing! !
!ChunkBrowserMethodDefineChunk categoriesFor: #initializeFromSeriesStart:!initializing!public! !
!ChunkBrowserMethodDefineChunk categoriesFor: #isMatch!public!testing! !
!ChunkBrowserMethodDefineChunk categoriesFor: #restore!operations!public! !
!ChunkBrowserMethodDefineChunk categoriesFor: #sourceFromImage!accessing!public! !

!ChunkBrowserMethodDefineChunk class methodsFor!

chunkType
	^#'Method Define'! !
!ChunkBrowserMethodDefineChunk class categoriesFor: #chunkType!constants!public! !

