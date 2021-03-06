"Filed out from Dolphin Smalltalk X6.1"!

GUID variableByteSubclass: #IID
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
IID guid: (GUID fromString: '{87B4C644-026E-11D3-9FD7-00A0CC3E4A32}')!
IID comment: 'IID is the class of 128-bit Globally Unique Identifiers (guids) which are specifically used to uniquely identify interfaces in COM.

Many interfaces are not recorded in the registry, but if they have marshalling support (a proxy/stub DLL) then they will be registered under HKCR\Interfaces. Registered IIDs will display with their registered name, otherwise the string representation of their GUID is printed.'!
!IID categoriesForClass!External-Data-Structured-COM! !
!IID methodsFor!

asString
	"Answer a string representation of the receiver which is expected to be a CLSID (if not
	an error may result)."

	| buf answer |
	buf := COMTaskMemory new.
	OLELibrary default stringFromIID: self lplpsz: buf.
	answer := String fromUnicodeString: buf.
	buf free.		"remove finalization overhead by explicity freeing"
	^answer

"
IUnknown iid asString
"!

displayOn: aStream
	"Append an 'end-user suitable' textual representation of the receiver to aStream.
	The interface name is rather more helpful, if available!!"

	| ifName |
	ifName := self interfaceName.
	ifName isNil 
		ifTrue: [super displayOn: aStream]
		ifFalse: [aStream nextPutAll: ifName]!

interfaceName
	"Answer the name of the interface associated with the receiver, or nil if it is
	not registered. This depends on the registry and is primarily included for
	development/debugging and tools, rather than for use in applications."

	^(((RegKey classesRoot: #read) at: 'Interface') at: self asString ifAbsent: [^nil]) value
! !
!IID categoriesFor: #asString!converting!public! !
!IID categoriesFor: #displayOn:!displaying!public! !
!IID categoriesFor: #interfaceName!accessing!public! !

!IID class methodsFor!

fromString: aString
	"Answer a new instance of the receiver instantiated from the argument, aString,
	which is in Microsoft(tm) GUID format."

	| answer unicodeString |
	answer := self newNull.
	unicodeString := aString asUnicodeString.
	OLELibrary default iidFromString: unicodeString lpiid: answer.
	^answer!

initialize
	"Private - Initialize the receiver's class variables.
		IID initialize
	"

	self extraInstanceSpec: self byteSize! !
!IID class categoriesFor: #fromString:!instance creation!public! !
!IID class categoriesFor: #initialize!development!initializing!private! !

