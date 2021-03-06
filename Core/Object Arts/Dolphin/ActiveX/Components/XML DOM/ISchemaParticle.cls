"Filed out from Dolphin Smalltalk X6"!

ISchemaItem subclass: #ISchemaParticle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'MSXMLConstants'
	classInstanceVariableNames: ''!
ISchemaParticle guid: (IID fromString: '{50EA08B5-DD1B-4664-9A50-C2F40F4BD79A}')!
ISchemaParticle comment: '<ISchemaParticle> is a wrapper class for the COM interface ''MSXML2.ISchemaParticle'' generated from type information in the ''Microsoft XML, v4.0'' library. It contains methods to invoke the member functions exposed by that interface.

The type library contains the following helpstring for this interface
	"XML Schema Particle"

Warning: This comment was automatically generated from the interface''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

[
	object, 
	uuid(50EA08B5-DD1B-4664-9A50-C2F40F4BD79A), 
	helpstring("XML Schema Particle"), 
	dual, 
	nonextensible
]
interface ISchemaParticle : ISchemaItem
 {
	[id(0x000005af), propget]
	HRESULT __stdcall minOccurs(
		[out, retval]VARIANT* minOccurs);
	[id(0x000005ab), propget]
	HRESULT __stdcall maxOccurs(
		[out, retval]VARIANT* maxOccurs);
};
'!
!ISchemaParticle categoriesForClass!COM-Interfaces!MSXML2-Interfaces! !
!ISchemaParticle methodsFor!

get_maxOccurs: maxOccurs
	"Private - Get the value of the 'maxOccurs' property of the receiver.

		HRESULT __stdcall maxOccurs(
			[out, retval]VARIANT* maxOccurs);"

	<virtual stdcall: hresult 16 variant*>
	^self invalidCall!

get_minOccurs: minOccurs
	"Private - Get the value of the 'minOccurs' property of the receiver.

		HRESULT __stdcall minOccurs(
			[out, retval]VARIANT* minOccurs);"

	<virtual stdcall: hresult 15 variant*>
	^self invalidCall!

maxOccurs
	"Answer the <variant> value of the 'maxOccurs' property of the receiver."

	| answer |
	answer := VARIANT new.
	self get_maxOccurs: answer.
	^answer asObject
!

minOccurs
	"Answer the <variant> value of the 'minOccurs' property of the receiver."

	| answer |
	answer := VARIANT new.
	self get_minOccurs: answer.
	^answer asObject
! !
!ISchemaParticle categoriesFor: #get_maxOccurs:!**auto generated**!COM Interfaces-ISchemaParticle!private! !
!ISchemaParticle categoriesFor: #get_minOccurs:!**auto generated**!COM Interfaces-ISchemaParticle!private! !
!ISchemaParticle categoriesFor: #maxOccurs!**auto generated**!properties!public! !
!ISchemaParticle categoriesFor: #minOccurs!**auto generated**!properties!public! !

!ISchemaParticle class methodsFor!

defineFunctions
	"Declare the virtual function table for the COM interface 'MSXML2.ISchemaParticle'
		ISchemaParticle defineTemplate"

	self
		defineFunction: #get_minOccurs:
			argumentTypes: 'variant*';
		defineFunction: #get_maxOccurs:
			argumentTypes: 'variant*'
! !
!ISchemaParticle class categoriesFor: #defineFunctions!**auto generated**!initializing!public! !

