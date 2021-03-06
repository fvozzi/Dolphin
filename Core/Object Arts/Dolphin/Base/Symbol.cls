"Filed out from Dolphin Smalltalk 7"!

String variableByteSubclass: #Symbol
	instanceVariableNames: ''
	classVariableNames: 'Table'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
Symbol guid: (GUID fromString: '{87B4C51D-026E-11D3-9FD7-00A0CC3E4A32}')!
Symbol isNullTerminated: true!
Symbol comment: 'Symbol is the class of <String>s which are guaranteed to be unique throughout the system.

Symbol complies with the following ANSI protocols:
	Object
	magnitude
	collection
	sequencedReadableCollection
	readableString
	symbol'!
!Symbol categoriesForClass!Collections-Text! !
!Symbol methodsFor!

= aSymbol
	"Symbols equality is the same as symbol identity since instances with the same
	characters are unique.
	The primitive should not fail."

	<primitive: 110>
	^self primitiveFailed!

argumentCount
	"Answer the <integer> number of arguments required by a method with the
	receiver as its selector."

	| argCount ch |
	self basicSize == 0 ifTrue: [^0].
	argCount := self occurrencesOf: $:.
	((ch := self at: 1) isLetter or: [ch == $_]) ifFalse: [
		argCount := argCount max: 1].
	^argCount!

asBlock
	"Answer a block capable of sending the receiver to an object"

	| arity |
	arity := self numArgs + 1.
	arity = 1 ifTrue: [^[:r | r perform: self]].
	arity = 2 ifTrue: [^[:r :a | r perform: self with: a]].
	arity = 3 ifTrue: [^[:r :a :b | r perform: self with: a with: b]].
	arity = 4 ifTrue: [^[:r :a :b :c| r perform: self with: a with: b with: c]].
	self error: 'Too many arguments'!

asString
	"Answer a new <readableString> containing the characters of 
	the receiver."

	^String fromString: self!

asSymbol
	"Answer the <symbol> containing the characters of the receiver
	(i.e. the receiver, since <symbol>s are unique)."

	^self!

deepCopy
	"Answer the receiver - Symbols are unique, so a copy with the same characters
	must not exist.
	N.B. This implementation may cause problems in generic code which attempts to
	modify copies of Strings!!"
	
	^self!

displayString
	"Answer a String representation of the receiver in a form suitable for
	presentation to an end user.
	Implementation Note: Because our superclass implements #displayString to
	return self (for better performance), we must override back to a suitable
	implementation for Symbols which does not include the hash prefix."

	^self basicCopy!

forwardTo: anObject
	"Send the <Object> argument the receiver as a niladic message,
	answering the result. Assumes the receiver is a unary selector."

	^anObject perform: self!

hash
	"Answer the <integer> hash value for the receiver.
	Override back to the 16-bit identity hash which is temporally invariant,
	and very fast to calculate).
	The primitve should not fail (but must not be used for immediate objects).
	N.B. It is critical that this implementation is not changed."

	<primitive: 75>
	^self primitiveFailed!

initialiseFrom: aString
	"Private - Initialize the receiver to contain the characters of aString.
	Sent to String because replaceFrom:with:startAt: is invalid for symbols"

	aString
		replaceBytesOf: self
		from: 1 to: aString size startingAt: 1
!

isInfix
	"Answer whether the receiver is valid as an infix message selector."

	^(Compiler isAValidInitialIdentifierChar: self first) not!

isSymbol
	"Dolphin doesn't usually include these type tests, but they are used by a number of add-on
	libraries, so we have begrudgingly accepted them into the base."

	^true!

keywords
	"Answer a <sequencedReadableCollection> of the receiver's keywords."

	self isEmpty ifTrue: [^#()].
	^self last == $:
		ifTrue: [(self subStrings: $:) collect: [:keyword | keyword, ':']]
		ifFalse: [Array with: self]!

numArgs
	^self argumentCount!

printArgumentTypeOn: aStream
	"Private - Append a compilable argument type name, which is the receiver, to aStream."

	self displayOn: aStream!

printOn: aStream
	"Append a textual description of the receiver to aStream. If the receiver includes
	embedded spaces, then quote it. This may need to be extended to include other
	whitespace/non-printing characters."

	aStream nextPut: $#.
	(self class isLiteralSymbol: self)
		ifTrue: [aStream nextPutAll: self]
		ifFalse: [super printOn: aStream]!

refersToLiteral: anObject 
	"Private - Answer whether the receiver is a reference to the literal argument.
	This assumes that the receiver is in the role of a literal."

	^self == anObject!

replaceFrom: start to: stop with: replacementCollection startingAt: repStart
	"Symbols are not mutable."

	^self shouldNotImplement
!

shallowCopy
	"Answer the receiver - Symbols are unique, so we must not create a copy
	with the same characters."

	^self!

species
	"Answer the generic type of String and its subclasses. Statically bind to
	the method's class so that subclasses will also answer that class."

	^String!

stbSaveOn: anSTBOutFiler 
	"Save out a binary representation of the receiver to anSTBOutFiler."

	anSTBOutFiler
		writePreambleFor: self;
		writeInteger: self size.
	anSTBOutFiler stream nextPutAll: self asByteArray! !
!Symbol categoriesFor: #=!comparing!public! !
!Symbol categoriesFor: #argumentCount!accessing!public! !
!Symbol categoriesFor: #asBlock!converting!public! !
!Symbol categoriesFor: #asString!converting!public! !
!Symbol categoriesFor: #asSymbol!converting!public! !
!Symbol categoriesFor: #deepCopy!copying!public! !
!Symbol categoriesFor: #displayString!printing!public! !
!Symbol categoriesFor: #forwardTo:!operations!public! !
!Symbol categoriesFor: #hash!comparing!public! !
!Symbol categoriesFor: #initialiseFrom:!initializing!private! !
!Symbol categoriesFor: #isInfix!public!testing! !
!Symbol categoriesFor: #isSymbol!public!RefactoringBrowser! !
!Symbol categoriesFor: #keywords!accessing!public! !
!Symbol categoriesFor: #numArgs!accessing!public! !
!Symbol categoriesFor: #printArgumentTypeOn:!printing!private! !
!Symbol categoriesFor: #printOn:!printing!public! !
!Symbol categoriesFor: #refersToLiteral:!private!testing! !
!Symbol categoriesFor: #replaceFrom:to:with:startingAt:!public!replacing! !
!Symbol categoriesFor: #shallowCopy!copying!public! !
!Symbol categoriesFor: #species!accessing!public! !
!Symbol categoriesFor: #stbSaveOn:!binary filing!public! !

Symbol methodProtocol: #commandMessage attributes: #(#readOnly) selectors: #(#asSymbol #forwardTo:)!
Symbol methodProtocol: #selector attributes: #(#ansi #readOnly) selectors: #()!
Symbol methodProtocol: #symbol attributes: #(#ansi #readOnly) selectors: #(#, #< #<= #> #>= #after: #asLowercase #asString #asSymbol #asUppercase #at: #at:ifAbsent: #before: #between:and: #copyFrom:to: #copyReplaceAll:with: #copyReplaceFrom:to:with: #copyReplaceFrom:to:withObject: #copyReplacing:withObject: #copyWith: #copyWithout: #do: #findFirst: #findLast: #first #from:to:do: #from:to:keysAndValuesDo: #indexOf: #indexOf:ifAbsent: #indexOfSubCollection:startingAt: #indexOfSubCollection:startingAt:ifAbsent: #keysAndValuesDo: #last #max: #min: #reverse #reverseDo: #sameAs: #subStrings: #with:do:)!

!Symbol class methodsFor!

addUnique: aSymbol 
	"Private - Add the argument aSymbol as a new entry in the Symbol Table. This private method should only be 
	used for adding Symbols not already present in the symbol table. Please use Symbol>>intern: to obtain
	a Symbol from a String (or alternatively String>>asSymbol)."

	| bucket bucketIndex |
	aSymbol isImmutable: true.
	bucketIndex := aSymbol hashCharacters \\ Table basicSize + 1.
	(bucket := Table basicAt: bucketIndex) isNil 
		ifTrue: [Table basicAt: bucketIndex put: (WeakArray with: aSymbol)]
		ifFalse: [bucket replaceIdentity: DeadObject current with: aSymbol].
	^aSymbol!

allInstancesDo: aMonadicValuable 
	"Evaluate the <monadicValuable> argument for each and every interned Symbol."

	Table do: [:eachBucket | eachBucket notNil ifTrue: [eachBucket nonCorpsesDo: aMonadicValuable]]!

findInterned: aString 
	"Answer the unique <Symbol> for aString if already defined, else nil.	
	N.B. This method previously had the selector #symbolAt:, and was private,
	but has been renamed and made public for compatibility with VisualWorks."

	(Table at: aString hashCharacters \\ Table basicSize + 1) ifNotNil: 
			[:bucket | 
			| corpse |
			corpse := DeadObject current.
			"Inline ArrayedCollection>>do: to avoid full block for best performance"
			1 to: bucket size
				do: 
					[:i | 
					| each |
					each := bucket at: i.
					(each == corpse == false and: [(aString trueCompare: each) == 0]) ifTrue: [^each]]].
	^nil!

fromString: aString
	"Answer a unique instance of the receiver whose contents are copied from aString."

	^self intern: aString!

icon
	"Answers an Icon that can be used to represent this class"

	^##(self) defaultIcon!

initialize
	"Initialize class variables of the receiver.
	
	Table	-	An Array which is used as a hash table containing WeakArray buckets, in which the currently used
				instances of the receiver are kept."

	Table isNil ifTrue: [Table := Array new: 3989]!

intern: aString
	"Answer the unique Symbol for aString."

	| symbol |
	(symbol := self findInterned: aString) isNil
		ifTrue: [
			symbol := (super new: aString size) initialiseFrom: aString.
			self addUnique: symbol].
	^symbol!

intern: aString cookie: cookie
	"Private - Callback from VM, returns the unique Symbol for aString.
	WARNING: Do not send this message from Smalltalk code. Do not modify or 
	remove this method."

	Processor callback: cookie evaluate: [self intern: aString]!

internCharacter: aCharacter
	"Answer the Character argument, aCharacter, as a single character unique symbol"

	^self intern: aCharacter asString!

isLiteralSymbol: aSymbol 
	"Private - Answer whether the <Symbol> argument is representable
	as an unquoted literal symbol."

	| size binChars |
	size := aSymbol basicSize.
	size == 0 ifTrue: [^false].
	binChars := '!!%&*+,/<=>?@\~|-'.
	(binChars identityIncludes: (aSymbol at: 1)) 
		ifTrue: 
			[aSymbol 
				from: 2
				to: size
				do: [:each | (binChars identityIncludes: each) ifFalse: [^false]]]
		ifFalse: 
			[| includesColon initial |
			initial := true.
			includesColon := false.
			aSymbol 
				from: 1
				to: size
				do: 
					[:each | 
					initial 
						ifTrue: [(each == $_ or: [each isEnglishLetter]) ifTrue: [initial := false] ifFalse: [^false]]
						ifFalse: 
							[each == $: 
								ifTrue: [includesColon := initial := true]
								ifFalse: [(each == $_ or: [each isEnglishLetter or: [each isDigit]]) ifFalse: [^false]]]].
			(includesColon and: [aSymbol last ~~ $:]) ifTrue: [^false]].
	^true!

new
	"Instances of the receiver can only be created by using the #intern: and #internCharacter:
	messages."

	^self shouldNotImplement!

resizeTable
	"Private - Remove unused Symbols from the system - must be done to the exclusion of other processes, e.g:
		[Symbol resizeTable] forkAt: Processor timingPriority.
	By default we select a symbol table bucket size of about 6. This is appropriate for a development image, which
	interns a lot of symbols, but a runtime image could easily accomodate larger buckets to reduce the symbol table
	size. Answers the new size of the table."

	^self resizeTable: 6
!

resizeTable: anInteger
	"Private - Change the size of the Symbol Table so that all of the existing symbols are in buckets
	the average length of which is approximately equal to the <integer> argument.
	N.B. The argument is not the size of the resulting symbol table, which is answered."

	 | newSize insts |
	insts := self allInstances.
	newSize := (Integer primesUpTo: insts size // anInteger) last.
	Table := Array new: newSize.
	insts do: [:symbol | self addUnique: symbol].
	^newSize!

stats
	"Private - Answer a String containing some statistics about the Symbol table
		self stats
	"

	| empty full count maxLen aStream corpses |
	empty := 0.
	full := 0.
	count := 0.
	maxLen := 0.
	corpses := 0.
	1 to: Table basicSize
		do: 
			[:i | 
			| l |
			(l := Table basicAt: i) isNil 
				ifTrue: [empty := empty + 1]
				ifFalse: 
					[| len |
					full := full + 1.
					len := 0.
					l 
						do: [:s | s == DeadObject current ifTrue: [corpses := corpses + 1] ifFalse: [len := len + 1]].
					count := count + len.
					maxLen := maxLen max: len]].
	aStream := String writeStream: 80.
	^aStream
		nextPutAll: 'Empty buckets:	';
		print: empty;
		cr;
		nextPutAll: 'Full buckets:	';
		print: full;
		cr;
		nextPutAll: 'Empty slots:	';
		print: corpses;
		cr;
		nextPutAll: 'Symbols:		';
		print: count;
		cr;
		nextPutAll: 'Max Bkt Len:	';
		print: maxLen;
		cr;
		nextPutAll: 'Avg Bkt Len:	';
		print: count / full asFloat;
		contents!

stbReadFrom: anSTBInFiler format: anSTBClassConversion 
	"Read an instance of the receiver from the binary filer, aSTBInFiler."

	| stream size answer bytes |
	anSTBInFiler version < 2 ifTrue: [^self stbReadFromProxy: anSTBInFiler].
	stream := anSTBInFiler stream.
	size := stream nextSDWORD.
	bytes := stream next: size.
	answer := self intern: (String fromString: bytes).
	anSTBInFiler register: answer.
	^answer!

stbReadFromProxy: anSTBInFiler 
	"Read and answer a <Symbol> from the binary in-filer argument, which is attached to an old
	format STB stream which used a proxy to store symbols."

	| answer ref |
	anSTBInFiler stream skip: 4.
	"Make a placeholder for the symbol"
	ref := anSTBInFiler register: nil.
	"Then read the string and intern it"
	answer := anSTBInFiler basicNext asSymbol.
	anSTBInFiler fixup: ref to: answer.
	^answer! !
!Symbol class categoriesFor: #addUnique:!accessing!private! !
!Symbol class categoriesFor: #allInstancesDo:!enumerating!public! !
!Symbol class categoriesFor: #findInterned:!accessing!public! !
!Symbol class categoriesFor: #fromString:!instance creation!public! !
!Symbol class categoriesFor: #icon!constants!public! !
!Symbol class categoriesFor: #initialize!development!initializing!public! !
!Symbol class categoriesFor: #intern:!instance creation!public! !
!Symbol class categoriesFor: #intern:cookie:!not restartable!private!vm entry points! !
!Symbol class categoriesFor: #internCharacter:!instance creation!public! !
!Symbol class categoriesFor: #isLiteralSymbol:!parsing!private! !
!Symbol class categoriesFor: #new!instance creation!public! !
!Symbol class categoriesFor: #resizeTable!initializing!private! !
!Symbol class categoriesFor: #resizeTable:!initializing!private! !
!Symbol class categoriesFor: #stats!development!private! !
!Symbol class categoriesFor: #stbReadFrom:format:!binary filing!public! !
!Symbol class categoriesFor: #stbReadFromProxy:!binary filing!private! !

