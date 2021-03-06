"Filed out from Dolphin Smalltalk X6"!

Category subclass: #ClassCategory
	instanceVariableNames: ''
	classVariableNames: 'Table Unclassified'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ClassCategory guid: (GUID fromString: '{87B4C500-026E-11D3-9FD7-00A0CC3E4A32}')!
ClassCategory comment: ''!
!ClassCategory categoriesForClass!Development! !
!ClassCategory methodsFor!

addClass: class
	"Add the <Class>, class, to the collection of classes associated with the receiver."

	class includeInCategory: self!

contents
	"Answer a Collection of all Class objects which are 
	held by the receiver."

	^self class environment allClasses select: [:aClass | self includesClass: aClass]!

includesClass: class 
	"Answer whether the receiver includes the <ClassDescription>, class."

	| classCategories |
	^(classCategories := class classCategories) isNil 
		ifTrue: [self == self class unclassified]
		ifFalse: [classCategories identityIncludes: self]!

removeClass: aClass
	"Remove aClass from the classes held by the reciver. Answer
	aMethod."

	aClass removeFromCategory: self.
	^aClass! !
!ClassCategory categoriesFor: #addClass:!adding!public! !
!ClassCategory categoriesFor: #contents!enumerating!public! !
!ClassCategory categoriesFor: #includesClass:!public!testing! !
!ClassCategory categoriesFor: #removeClass:!public!removing! !

!ClassCategory class methodsFor!

allClassCategories
	"Answer the set of all <classCategory>s current registered in the system."

	^Table asArray!

initialize
	"Private - Initialize the receiver's class variables.

	This is a No-Op because we have to create the table
	during the booting process of Dolphin so all the methods
	categories can be set as they are loaded. Support for the booting
	of the system is unnecessary in the release version of Dolphin but
	it resolves the conundrom of creating the Smalltalk system, which
	relies on itself to work, from nothing using smalltalk. 

	It is unwise to clear down this table, as the development system
	expects methods and classes to be correctly categorized."
"	| newTable |

	newTable := WeakLookupTable new.
	newTable addAll: Table associations.
	Table := newTable"

	"During the boot, weakness doesn't work properly, so some repairs may be needed"
	Unclassified := self newNamed: self unclassifiedName.
	Table 
		at: self unclassifiedName put: Unclassified;
		removeKey: 'No category' ifAbsent: []!

name: cat
	"Answer a new or existing class category with the specified name."

	| nameString |
	nameString := cat asString.
	^nameString isEmpty 
		ifTrue: [self unclassified]
		ifFalse: [Table at: nameString ifAbsentPut: [self newNamed: nameString]]!

unclassified
	"Answer a <ClassCategory> used to mark an unclassified classes."

	^Unclassified!

unclassifiedName
	"Private - Answer the String name used to mark a none existing category."

	^ 'Unclassified'!

uninitialize
	"Private - Uninitialize the receiver as it is about to be removed from the system."

	Table := nil.
	Unclassified := nil! !
!ClassCategory class categoriesFor: #allClassCategories!accessing!public! !
!ClassCategory class categoriesFor: #initialize!initializing!private! !
!ClassCategory class categoriesFor: #name:!instance creation!public! !
!ClassCategory class categoriesFor: #unclassified!instance creation!public! !
!ClassCategory class categoriesFor: #unclassifiedName!constants!private! !
!ClassCategory class categoriesFor: #uninitialize!class hierarchy-removing!private! !

