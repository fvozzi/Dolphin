"Filed out from Dolphin Smalltalk X6.1"!

Win32Error subclass: #SocketError
	instanceVariableNames: ''
	classVariableNames: 'ErrorClasses'
	poolDictionaries: 'WinSocketConstants WinSocketErrors'
	classInstanceVariableNames: ''!
SocketError guid: (GUID fromString: '{87B4C560-026E-11D3-9FD7-00A0CC3E4A32}')!
SocketError comment: 'This exception signals that a general Socket error has occurred. The actual error can be identified using #statusCode and its textual description is available using #osErrorMessage.'!
!SocketError categoriesForClass!Windows Sockets! !
!SocketError methodsFor!

errorAsString
	"Answer a String representation of the error code."

	#deprecated. "6.0"
	^self osErrorMessage!

errorCode
	#deprecated. "6.0"
	^self statusCode! !
!SocketError categoriesFor: #errorAsString!displaying!public! !
!SocketError categoriesFor: #errorCode!accessing!public! !

!SocketError class methodsFor!

basicSignalWith: anInteger 
	^self new signalWith: (HRESULT win32Error: anInteger)!

errorCode
	^WS2_32Library default WSAGetLastError!

initialize
	ErrorClasses := LookupTable new.
	!

signal
	"Raise a new instance of the receiver containing the error code of the last socket error."

	self signalWith: self errorCode!

signalWith: anInteger 
	"Raise a new instance of the receiver containing the <integer> WSA
	error code parameter."

	^(ErrorClasses at: anInteger ifAbsent: [self]) basicSignalWith: anInteger
! !
!SocketError class categoriesFor: #basicSignalWith:!instance creation!private! !
!SocketError class categoriesFor: #errorCode!enquiries!private! !
!SocketError class categoriesFor: #initialize!public! !
!SocketError class categoriesFor: #signal!instance creation!public! !
!SocketError class categoriesFor: #signalWith:!instance creation!public! !

