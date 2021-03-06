"Filed out from Dolphin Smalltalk X6.1"!

OLEFinalizableStructure subclass: #EXCEPINFO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'Win32Errors'
	classInstanceVariableNames: ''!
EXCEPINFO guid: (GUID fromString: '{C06F3B63-0868-11D3-93AF-00A024CA708A}')!
EXCEPINFO comment: 'EXCEPINFO is the class of <ExternalStructure>s representing the OLE Automation structure of the same name. EXCEPINFO is used to return exception details from IDispatch::Invoke().'!
!EXCEPINFO categoriesForClass!External-Data-Structured-COM! !
!EXCEPINFO methodsFor!

_deepCopy: copiesDictionary 
	"Private - Answer a 'deep copy' of the receiver, cloning only those parts not already included
	in the IdentityDictionary argument, copiesDictionary."

	"Implementation Note: We have no copiable instance variables, but must copy the BSTRs embedded
	in the structure, something which our #copy implementation does."

	^self copy!

bstrDescription
	"Answer the receiver's bstrDescription field as a Smalltalk object."

	^BSTR fromAddress: self pwszDescription!

bstrDescription: anObject 
	"Set the receiver's bstrDescription field to the value of anObject."

	self pwszDescription: anObject yourAddress!

bstrHelpFile
	"Answer the receiver's bstrHelpFile field as a Smalltalk object."

	^BSTR fromAddress: self pwszHelpFile!

bstrHelpFile: anObject 
	"Set the receiver's bstrHelpFile field to the value of anObject."

	self pwszHelpFile: anObject yourAddress!

bstrSource
	"Answer the receiver's bstrSource field as a Smalltalk object."

	^BSTR fromAddress: self pwszSource!

bstrSource: anObject 
	"Set the receiver's bstrSource field to the value of anObject."

	self pwszSource: anObject yourAddress!

copy
	"Answer an <EXCEPINFO> which is a copy of the receiver. The embedded BSTRs
	must be copied (the accessor copies because BSTR>>fromAddress: copies)."

	| copy |
	copy := super copy.
	copy bstrSource: self bstrSource detach.
	copy bstrDescription: self bstrDescription detach.
	copy bstrHelpFile: self bstrHelpFile detach.
	^copy!

description
	"Answer the receiver's bstrDescription field as a <readableString> Smalltalk object.
	This is the error string set by the object which reported the error."

	^self wstrDescription asString!

description: errorDescription
	"Set the receiver's bstrDescription field to a <BSTR> copy of the <readableString>
	or <BSTR> argument."

	| bstr |
	(bstr := errorDescription asBSTR) == errorDescription
		ifTrue: [bstr := errorDescription copy].
	self bstrDescription: bstr detach.!

dwHelpContext
	"Answer the receiver's dwHelpContext field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #dwHelpContext)!

dwHelpContext: anObject 
	"Set the receiver's dwHelpContext field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #dwHelpContext) put: anObject!

helpFile
	"Answer the receiver's bstrHelpFile field as a <readableString> Smalltalk object."

	^self wstrHelpFile asString!

helpFile: helpFilePath
	"Set the receiver's bstrHelpFile field to a <BSTR> copy of the <readableString>
	or <BSTR> argument."

	| bstr |
	(bstr := helpFilePath asBSTR) == helpFilePath
		ifTrue: [bstr := helpFilePath copy].
	self bstrHelpFile: bstr detach.!

hresult
	"Answer the HRESULT associated with the receiver.
	This may need to be generated from the error code, depending on which was specified."

	| wCode |
	wCode := self wCode.
	^wCode == 0 
		ifTrue: [self scode]
		ifFalse: 
			[wCode >= 16rFE00 ifTrue: [WCODE_HRESULT_LAST] ifFalse: [WCODE_HRESULT_FIRST + wCode]]!

pfnDeferredFillIn
	"Answer the receiver's pfnDeferredFillIn field as a Smalltalk object."

	^(bytes uintPtrAtOffset: ##(self offsetOf: #pfnDeferredFillIn)) asExternalAddress!

pwszDescription
	"Answer the receiver's pwszDescription field as a Smalltalk object."

	^bytes uintPtrAtOffset: ##(self offsetOf: #pwszDescription)!

pwszDescription: anObject 
	"Set the receiver's pwszDescription field to the value of anObject."

	bytes uintPtrAtOffset: ##(self offsetOf: #pwszDescription) put: anObject!

pwszHelpFile
	"Answer the receiver's pwszHelpFile field as a Smalltalk object."

	^bytes uintPtrAtOffset: ##(self offsetOf: #pwszHelpFile)!

pwszHelpFile: anObject 
	"Set the receiver's pwszHelpFile field to the value of anObject."

	bytes uintPtrAtOffset: ##(self offsetOf: #pwszHelpFile) put: anObject!

pwszSource
	"Answer the receiver's pwszSource field as a Smalltalk object."

	^bytes uintPtrAtOffset: ##(self offsetOf: #pwszSource)!

pwszSource: anObject 
	"Set the receiver's pwszSource field to the value of anObject."

	bytes uintPtrAtOffset: ##(self offsetOf: #pwszSource) put: anObject!

scode
	"Answer the receiver's scode field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #scode)!

scode: anObject 
	"Set the receiver's scode field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #scode) put: anObject!

source
	"Answer a <readableString> description of the source of the error.
	This should be the error source's version independent Prog ID, but some objects
	do not follow the convention."

	^self wstrSource asString!

source: errorSourceString
	"Set the receiver's bstrSource field to a <BSTR> copy of the <readableString>
	or <BSTR> argument."

	| bstr |
	(bstr := errorSourceString asBSTR) == errorSourceString
		ifTrue: [bstr := errorSourceString copy].
	self bstrSource: bstr detach.!

wCode
	"Answer the receiver's wCode field as a Smalltalk object."

	^bytes wordAtOffset: 0!

wCode: anObject 
	"Set the receiver's wCode field to the value of anObject."

	bytes wordAtOffset: 0 put: anObject!

wstrDescription
	"Answer the receiver's bstrDescription field as a <UnicodeString>."

	^UnicodeString fromAddress: self pwszDescription!

wstrHelpFile
	"Answer the receiver's bstrHelpFile field as a <UnicodeString>."

	^UnicodeString fromAddress: self pwszHelpFile!

wstrSource
	"Answer the receiver's bstrSource field as a <UnicodeString> Smalltalk object."

	^UnicodeString fromAddress: self pwszSource! !
!EXCEPINFO categoriesFor: #_deepCopy:!copying!private! !
!EXCEPINFO categoriesFor: #bstrDescription!accessing!public! !
!EXCEPINFO categoriesFor: #bstrDescription:!accessing!public! !
!EXCEPINFO categoriesFor: #bstrHelpFile!accessing!public! !
!EXCEPINFO categoriesFor: #bstrHelpFile:!accessing!public! !
!EXCEPINFO categoriesFor: #bstrSource!accessing!public! !
!EXCEPINFO categoriesFor: #bstrSource:!accessing!public! !
!EXCEPINFO categoriesFor: #copy!copying!public! !
!EXCEPINFO categoriesFor: #description!accessing!public! !
!EXCEPINFO categoriesFor: #description:!accessing!public! !
!EXCEPINFO categoriesFor: #dwHelpContext!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #dwHelpContext:!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #helpFile!accessing!public! !
!EXCEPINFO categoriesFor: #helpFile:!accessing!public! !
!EXCEPINFO categoriesFor: #hresult!accessing!public! !
!EXCEPINFO categoriesFor: #pfnDeferredFillIn!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #pwszDescription!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #pwszDescription:!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #pwszHelpFile!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #pwszHelpFile:!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #pwszSource!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #pwszSource:!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #scode!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #scode:!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #source!accessing!public! !
!EXCEPINFO categoriesFor: #source:!accessing!public! !
!EXCEPINFO categoriesFor: #wCode!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #wCode:!**compiled accessors**!public! !
!EXCEPINFO categoriesFor: #wstrDescription!accessing!public! !
!EXCEPINFO categoriesFor: #wstrHelpFile!accessing!public! !
!EXCEPINFO categoriesFor: #wstrSource!accessing!public! !

!EXCEPINFO class methodsFor!

clear: addressOrBytes
	"Free external resources referenced by the structure
	of the receiver's element type at the specified address."

	| lib |
	lib := OLEAutLibrary default.
	4 to: 12 by: 4 do: [:offset | lib sysFreeString: (addressOrBytes sdwordAtOffset: offset)]
!

defineFields
	"Define the fields of the EXCEPINFO structure.

		EXCEPINFO compileDefinition.

		struct EXCEPINFO 
		{
			unsigned short wCode;			// An error code describing the error.
			unsigned short wReserved;    
			BSTR bstrSource;				// Source of the exception.
			BSTR bstrDescription;			// Textual description of the error.
			BSTR bstrHelpFile;				// Help file path.
			unsigned long dwHelpContext;	// Help context ID.    
			void FAR* pvReserved;			// Pointer to function that fills in Help and description info.
			HRESULT (STDAPICALLTYPE FAR* pfnDeferredFillIn)(struct tagEXCEPINFO FAR*);
			SCODE scode;					// Error code
		}; 
	"

	self
		defineField: #wCode type: WORDField new;
		defineField: #wReserved type: WORDField filler;
		defineField: #pwszSource type: UINT_PTRField new;
		defineField: #pwszDescription type: UINT_PTRField new;
		defineField: #pwszHelpFile type: UINT_PTRField new;
		defineField: #dwHelpContext type: DWORDField new;
		defineField: #pvReserved type: LPVOIDField filler;
		defineField: #pfnDeferredFillIn type: LPVOIDField readOnly;
		defineField: #scode type: SDWORDField new! !
!EXCEPINFO class categoriesFor: #clear:!public!realizing/unrealizing! !
!EXCEPINFO class categoriesFor: #defineFields!initializing!public! !

