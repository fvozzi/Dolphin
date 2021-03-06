"Filed out from Dolphin Smalltalk 7"!

SmalltalkSystem subclass: #CommunityEditionSmalltalkSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
CommunityEditionSmalltalkSystem guid: (GUID fromString: '{FE94A239-C422-4A02-A575-5E7923CE1D63}')!
CommunityEditionSmalltalkSystem comment: ''!
!CommunityEditionSmalltalkSystem categoriesForClass!Development! !
!CommunityEditionSmalltalkSystem methodsFor!

initializeSystemFolder

	super initializeSystemFolder.
	self
		addSystemFolderIcon: (SmalltalkSystemFolder description: 'Sample Applications' helpId: 10560);
		addSystemFolderIcon: (SmalltalkSystemFolder 
					icon: self userPreferencesIcon
					description: 'User Preferences'
					openBlock: [:folder :item | self inspectSystemOptions]
					helpId: 10580)! !
!CommunityEditionSmalltalkSystem categoriesFor: #initializeSystemFolder!initializing!private! !

!CommunityEditionSmalltalkSystem class methodsFor!

initialize
	"Private - Initialize the receiver on load (take over as the development system model)."

	self installCurrent!

installCurrent
	"Private - Take over as the development system model."

	self current become: (self basicNew initializeFrom: self current)!

uninitialize
	"Private - Uninitialize the receiver as it is about to be removed from the system."

	self uninstallCurrent!

uninstallCurrent
	(Current notNil and: [Current class == self]) 
		ifTrue: 
			[(self superclass basicNew)
				initializeFrom: Current;
				become: Current]! !
!CommunityEditionSmalltalkSystem class categoriesFor: #initialize!initializing!private! !
!CommunityEditionSmalltalkSystem class categoriesFor: #installCurrent!initializing!private! !
!CommunityEditionSmalltalkSystem class categoriesFor: #uninitialize!class hierarchy-removing!private! !
!CommunityEditionSmalltalkSystem class categoriesFor: #uninstallCurrent!class hierarchy-removing!private! !

