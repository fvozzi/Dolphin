"Filed out from Dolphin Smalltalk X6.1"!

Win32Structure subclass: #MINMAXINFO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
MINMAXINFO guid: (GUID fromString: '{76EBD637-6AB0-4D00-812C-FA6942E1318E}')!
MINMAXINFO comment: '<MINMAXINFO> is an <ExternalStructure> class to wrap the struct ''Win.MINMAXINFO'' from type information in the ''Windows API (ANSI)'' library.

The type library contains no documentation for this struct

Warning: This comment was automatically generated from the struct''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

typedef struct tagMINMAXINFO {
	POINTL ptReserved;
	POINTL ptMaxSize;
	POINTL ptMaxPosition;
	POINTL ptMinTrackSize;
	POINTL ptMaxTrackSize;
} MINMAXINFO;
'!
!MINMAXINFO categoriesForClass!Win-Structs! !
!MINMAXINFO methodsFor!

ptMaxTrackSize
	"Answer the receiver's ptMaxTrackSize field as a Smalltalk object."

	^POINTL fromAddress: bytes yourAddress + ##(self offsetOf: #ptMaxTrackSize)!

ptMaxTrackSize: anObject 
	"Set the receiver's ptMaxTrackSize field to the value of anObject."

	anObject 
		replaceBytesOf: bytes
		from: ##((self offsetOf: #ptMaxTrackSize) + 1)
		to: ##((self offsetOf: #ptMaxTrackSize) + POINTL basicByteSize)
		startingAt: 1!

ptMinTrackSize
	"Answer the receiver's ptMinTrackSize field as a Smalltalk object."

	^POINTL fromAddress: bytes yourAddress + ##(self offsetOf: #ptMinTrackSize)!

ptMinTrackSize: anObject 
	"Set the receiver's ptMinTrackSize field to the value of anObject."

	anObject 
		replaceBytesOf: bytes
		from: ##((self offsetOf: #ptMinTrackSize) + 1)
		to: ##((self offsetOf: #ptMinTrackSize) + POINTL basicByteSize)
		startingAt: 1! !
!MINMAXINFO categoriesFor: #ptMaxTrackSize!**compiled accessors**!public! !
!MINMAXINFO categoriesFor: #ptMaxTrackSize:!**compiled accessors**!public! !
!MINMAXINFO categoriesFor: #ptMinTrackSize!**compiled accessors**!public! !
!MINMAXINFO categoriesFor: #ptMinTrackSize:!**compiled accessors**!public! !

!MINMAXINFO class methodsFor!

defineFields
	"Define the fields of the MINMAXINFO structure.
		MINMAXINFO compileDefinition
	
		typedef 		struct tagMINMAXINFO {
			POINTL ptReserved;
			POINTL ptMaxSize;
			POINTL ptMaxPosition;
			POINTL ptMinTrackSize;
			POINTL ptMaxTrackSize;
		} MINMAXINFO;
"

	self
		defineField: #ptReserved type: (StructureField type: POINTL) beFiller;
		defineField: #ptMaxSize type: (StructureField type: POINTL) beUncompiled;
		defineField: #ptMaxPosition type: (StructureField type: POINTL) beUncompiled;
		defineField: #ptMinTrackSize type: (StructureField type: POINTL);
		defineField: #ptMaxTrackSize type: (StructureField type: POINTL)! !
!MINMAXINFO class categoriesFor: #defineFields!initializing!public! !

