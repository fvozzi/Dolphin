"Filed out from Dolphin Smalltalk 7"!

AbstractParserErrorTest subclass: #CompilerErrorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'CompilerFlags'
	classInstanceVariableNames: ''!
CompilerErrorTest guid: (GUID fromString: '{46595911-E729-41D5-92F4-57241CF25EAC}')!
CompilerErrorTest comment: ''!
!CompilerErrorTest categoriesForClass!Unclassified! !
!CompilerErrorTest methodsFor!

compilationErrorClass
	^Compiler errorClass!

compilationWarningClass
	^Compiler warningClass!

defaultCompileFlags
	^Interactive "| SyntaxCheckOnly"

 

!

parseExpression: aString in: aClass 
	^Compiler 
		compileForEvaluation: aString
		in: aClass
		evaluationPools: #()
		logged: false
		flags: self defaultCompileFlags!

parseMethod: aString in: aClass 
	^Compiler 
		compile: aString
		in: aClass
		flags: self defaultCompileFlags!

testErrorsLexical
	"Invalid const"

	super testErrorsLexical.
	self 
		parseExprError: '###'
		range: (3 to: 3)
		line: 1
		code: LErrExpectExtendedLiteral
		message: ((self errorFormats at: LErrExpectExtendedLiteral) expandMacrosWith: $()!

testErrorsNonsenseAtEndOfExpression
	self 
		parseExprError: '1+2]3'
		range: (1 to: 3)
		line: 1
		code: CErrUnterminatedStatement.
	self 
		parseExprError: ' ##(1+2]3)'
		range: (5 to: 7)
		line: 1
		code: CErrUnterminatedStatement!

testErrorsNonsenseAtEndOfMethod
	"Nonense at end of method - not sure how to get this error to emerge - can do it with the Smalltalk Parser with an expression like.
		x 1 ]
	i..e with an extraneous close square bracket, but this yields an unterminated statement or invalid expression start from the C++ compiler."

	| source mark |
	source := 'blah ^1+2]'.
	self 
		parseMethodError: source
		code: CErrUnterminatedStatement
		range: ((source indexOf: $^) to: (source indexOf: $]) - 1).
	source := '1+2]. 3+4'.
	self 
		parseExprError: source
		range: (1 to: 3)
		line: 1
		code: CErrUnterminatedStatement.
	source := '1+2.] 3+4'.
	mark := source indexOf: $].
	self 
		parseExprError: source
		range: (mark to: mark)
		line: 1
		code: CErrInvalExprStart!

testErrorsTooManyBytecodes
	"This is one error that the parser cannot detect since it does not do code generation.
	The number of bytecodes in a method has no real limit, except that imposed by the
	maximum lengths of jumps (and in practice by the maximum size of the literal frame).
	In order to provoke the 'method tool long' error we need to generate a long jump
	around a large inlined block. To avoid requring a lot of literals we use expressions
	with immediate values, i.e. 1+2 .Each 1+2 sequence generates 4 bytecodes:
		Push 1
		Push 2
		Send +
		Pop.
	The maximum length of a jump is 32k."

	| source max |
	source := String writeStream.
	source
		nextPutAll: 'Object isNil ifFalse: [';
		cr.
	max := 32768 / 4.
	1 to: max
		do: 
			[:i |
			source
				nextPutAll: '1+2.';
				cr].
	source nextPut: $].
	source := source contents.
	self
		parseExprError: source
		range: (source size + 1 to: source size)
		line: max + 2
		code: CErrMethodTooLarge! !
!CompilerErrorTest categoriesFor: #compilationErrorClass!constants!private! !
!CompilerErrorTest categoriesFor: #compilationWarningClass!constants!private! !
!CompilerErrorTest categoriesFor: #defaultCompileFlags!private! !
!CompilerErrorTest categoriesFor: #parseExpression:in:!private! !
!CompilerErrorTest categoriesFor: #parseMethod:in:!private!unit tests! !
!CompilerErrorTest categoriesFor: #testErrorsLexical!exceptions!public!unit tests! !
!CompilerErrorTest categoriesFor: #testErrorsNonsenseAtEndOfExpression!public!unit tests! !
!CompilerErrorTest categoriesFor: #testErrorsNonsenseAtEndOfMethod!exceptions!public!unit tests! !
!CompilerErrorTest categoriesFor: #testErrorsTooManyBytecodes!public!unit tests! !

