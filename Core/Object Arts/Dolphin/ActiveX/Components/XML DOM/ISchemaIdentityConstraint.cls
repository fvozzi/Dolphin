"Filed out from Dolphin Smalltalk X6"!

ISchemaItem subclass: #ISchemaIdentityConstraint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'MSXMLConstants'
	classInstanceVariableNames: ''!
ISchemaIdentityConstraint guid: (IID fromString: '{50EA08BD-DD1B-4664-9A50-C2F40F4BD79A}')!
ISchemaIdentityConstraint comment: '<ISchemaIdentityConstraint> is a wrapper class for the COM interface ''MSXML2.ISchemaIdentityConstraint'' generated from type information in the ''Microsoft XML, v4.0'' library. It contains methods to invoke the member functions exposed by that interface.

The type library contains the following helpstring for this interface
	"XML Schema Any"

Warning: This comment was automatically generated from the interface''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

[
	object, 
	uuid(50EA08BD-DD1B-4664-9A50-C2F40F4BD79A), 
	helpstring("XML Schema Any"), 
	dual, 
	nonextensible
]
interface ISchemaIdentityConstraint : ISchemaItem
 {
	[id(0x000005be), propget]
	HRESULT __stdcall selector(
		[out, retval]BSTR* selector);
	[id(0x0000059c), propget]
	HRESULT __stdcall fields(
		[out, retval]ISchemaStringCollection** fields);
	[id(0x000005ba), propget]
	HRESULT __stdcall referencedKey(
		[out, retval]ISchemaIdentityConstraint** key);
};
'!
!ISchemaIdentityConstraint categoriesForClass!COM-Interfaces!MSXML2-Interfaces! !
!ISchemaIdentityConstraint methodsFor!

fields
	"Answer the <ISchemaStringCollection> value of the 'fields' property of the receiver."

	| answer |
	answer := ISchemaStringCollection newPointer.
	self get_fields: answer.
	^answer asObject
!

get_fields: fields
	"Private - Get the value of the 'fields' property of the receiver.

		HRESULT __stdcall fields(
			[out, retval]ISchemaStringCollection** fields);"

	<virtual stdcall: hresult 16 ISchemaStringCollection**>
	^self invalidCall!

get_referencedKey: key
	"Private - Get the value of the 'referencedKey' property of the receiver.

		HRESULT __stdcall referencedKey(
			[out, retval]ISchemaIdentityConstraint** key);"

	<virtual stdcall: hresult 17 ISchemaIdentityConstraint**>
	^self invalidCall!

get_selector: selector
	"Private - Get the value of the 'selector' property of the receiver.

		HRESULT __stdcall selector(
			[out, retval]BSTR* selector);"

	<virtual stdcall: hresult 15 bstr*>
	^self invalidCall!

referencedKey
	"Answer the <ISchemaIdentityConstraint> value of the 'referencedKey' property of the receiver."

	| answer |
	answer := ISchemaIdentityConstraint newPointer.
	self get_referencedKey: answer.
	^answer asObject
!

selector
	"Answer the <bstr> value of the 'selector' property of the receiver."

	| answer |
	answer := BSTR new.
	self get_selector: answer.
	^answer asObject
! !
!ISchemaIdentityConstraint categoriesFor: #fields!**auto generated**!properties!public! !
!ISchemaIdentityConstraint categoriesFor: #get_fields:!**auto generated**!COM Interfaces-ISchemaIdentityConstraint!private! !
!ISchemaIdentityConstraint categoriesFor: #get_referencedKey:!**auto generated**!COM Interfaces-ISchemaIdentityConstraint!private! !
!ISchemaIdentityConstraint categoriesFor: #get_selector:!**auto generated**!COM Interfaces-ISchemaIdentityConstraint!private! !
!ISchemaIdentityConstraint categoriesFor: #referencedKey!**auto generated**!properties!public! !
!ISchemaIdentityConstraint categoriesFor: #selector!**auto generated**!properties!public! !

!ISchemaIdentityConstraint class methodsFor!

defineFunctions
	"Declare the virtual function table for the COM interface 'MSXML2.ISchemaIdentityConstraint'
		ISchemaIdentityConstraint defineTemplate"

	self
		defineFunction: #get_selector:
			argumentTypes: 'bstr*';
		defineFunction: #get_fields:
			argumentTypes: 'ISchemaStringCollection**';
		defineFunction: #get_referencedKey:
			argumentTypes: 'ISchemaIdentityConstraint**'
! !
!ISchemaIdentityConstraint class categoriesFor: #defineFunctions!**auto generated**!initializing!public! !

