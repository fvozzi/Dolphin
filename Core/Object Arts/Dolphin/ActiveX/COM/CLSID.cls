"Filed out from Dolphin Smalltalk X6.1"!

GUID variableByteSubclass: #CLSID
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
CLSID guid: (GUID fromString: '{87B4C643-026E-11D3-9FD7-00A0CC3E4A32}')!
CLSID comment: 'CLSID the class of 128-bit Globally Unique Identifiers (guids) which are specifically used to uniquely identify coclasses (components) in COM.

The CLSIDs of all coclasses registered on your machine can be found under the HKCR\CLSID key in your registry. Each correctly formed entry will have a human (are VB programmers human?) readable form (a ProgID) directly under HKCR.'!
!CLSID categoriesForClass!External-Data-Structured-COM! !
!CLSID methodsFor!

asString
	"Answer a string representation of the receiver which is expected to be a CLSID (if not
	an error may result)."

	| buf answer |
	buf := COMTaskMemory new.
	OLELibrary default stringFromCLSID: self lplpsz: buf.
	answer := String fromUnicodeString: buf.
	buf free.		"remove finalization overhead by explicity freeing"
	^answer!

displayOn: aStream
	"Append an 'end-user suitable' textual representation of the receiver to aStream.
	GUIDs are a fairly technical concept, but they do appear in the registry in a
	certain format, which we use here."

	[aStream nextPutAll: self progID] on: HRESULTError do: [:e |
		aStream 
"			nextPutAll: ' (Unregistered) ';"
			nextPutAll: self asString]!

progID
	"Answer the ProgID associated with the receiver (if any). The result
	is a String, but is not really appropriate for end-user display.
	If the registry contains no relevant entry, then an appropriate
	HRESULTError will be raised.
	Note that a ProgID has a maximum of 39 characters."

	| pProgId |
	pProgId := COMTaskMemory new.
	OLELibrary default progIDFromCLSID: self lplpszProgID: pProgId.
	^(UnicodeString fromAddress: pProgId) asString! !
!CLSID categoriesFor: #asString!converting!public! !
!CLSID categoriesFor: #displayOn:!displaying!public! !
!CLSID categoriesFor: #progID!displaying!public! !

!CLSID class methodsFor!

fromProgID: aString 
	"Answer a new instance of the receiver instantiated from the argument, aString,
	which contains a ProgID which is expected to be in the registry."

	| answer |
	answer := self newNull.
	OLELibrary default clsidFromProgID: aString asUnicodeString lpclsid: answer.
	^answer!

fromString: aString 
	"Answer an instance of the receiver instantiated from the argument, aString."

	| answer unicodeString |
	aString isEmpty ifTrue: [^self null].
	aString first ~~ ${ ifTrue: [^self fromProgID: aString].
	answer := self newNull.
	unicodeString := aString asUnicodeString.
	OLELibrary default clsidFromString: unicodeString pclsid: answer.
	^answer!

initialize
	"Private - Initialize the receiver's class variables.
		CLSID initialize
	"

	self extraInstanceSpec: self byteSize! !
!CLSID class categoriesFor: #fromProgID:!instance creation!public! !
!CLSID class categoriesFor: #fromString:!instance creation!public! !
!CLSID class categoriesFor: #initialize!development!initializing!private! !

