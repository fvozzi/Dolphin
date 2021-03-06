"Filed out from Dolphin Smalltalk X6.1"!

ExternalStructure subclass: #LPVOID
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
LPVOID guid: (GUID fromString: '{87B4C596-026E-11D3-9FD7-00A0CC3E4A32}')!
LPVOID comment: 'LPVOID is an <ExternalStructure> class useful for representing pointers to arbitrary external memory blocks. In most respects LPVOID behaves like <ExternalAddress>, except that instances may be allocated using #newBuffer which can be passed to #lpvoid arguments without the VM implicitly dereferencing the address (i.e. the behaviour will be the same as if an ExternalAddress had been passed to an lppvoid parameter). LPVOID is also a pointer object, and can thus add instance variables to hold additional state.

LPVOID is useful, for example, where references to pointers (i.e. VOID**) are required, an example being COM [out] pointer parameters. The VM also passes instances of LPVOID as lpvoid input parameters to callbacks and COM method implementations.

It is important to realise that LPVOID (and subclasses) are unlike other ExternalStructures in that they are already pointers, and therefore they already incorporate one level of indirection. Thus:
1) #value answers the pointed at address in the case of doubly-indirect (reference) instances, or the address itself for internal buffer instances.
2) The class method #fromAddress: will answer a pointer to a pointer, i.e. a double-indirection. This means that, for example, the subclass LPWSTR is useful as an element class for a <StructureArray> of LPWSTR pointers (as expected), but that ''LPWSTR fromAdddress: aUnicodeString yourAddress'' is not valid.'!
!LPVOID categoriesForClass!External-Data-Structured! !
!LPVOID methodsFor!

asExternalAddress
	"Answer the address contained in or referenced by the receiver."

	^self value!

value
	"Answer the receiver's value field as a Smalltalk object."

	^(bytes uintPtrAtOffset: 0) asExternalAddress!

value: anObject 
	"Set the receiver's value field to the value of anObject."

	bytes uintPtrAtOffset: 0 put: anObject! !
!LPVOID categoriesFor: #asExternalAddress!converting!public! !
!LPVOID categoriesFor: #value!**compiled accessors**!public! !
!LPVOID categoriesFor: #value:!**compiled accessors**!public! !

!LPVOID class methodsFor!

defineFields
	"Define the fields of the LPVOID 'structure'.
		LPVOID compileDefinition
	"

	self defineField: #value type: LPVOIDField new!

new
	"Answer a new instance of the receiver.
	Implementation Note: LPVOID and its subclasses represent pointers, and are typically
	used for double indirections, thus a reference is normally required."

	^self newPointer! !
!LPVOID class categoriesFor: #defineFields!initializing!public! !
!LPVOID class categoriesFor: #new!instance creation!public! !

