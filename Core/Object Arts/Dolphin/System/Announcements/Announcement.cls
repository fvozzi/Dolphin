"Filed out from Dolphin Smalltalk 7"!

Object subclass: #Announcement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
Announcement guid: (GUID fromString: '{12525B20-16EF-4684-B01E-956B227A429D}')!
Announcement comment: 'This class is the superclass for events that someone might want to announce, such as a button click or an attribute change. Typically you create subclasses for your own events you want to announce. '!
!Announcement categoriesForClass!Announcements-Core! !
!Announcement methodsFor!

asAnnouncement	^ self! !
!Announcement categoriesFor: #asAnnouncement!converting!public! !

!Announcement class methodsFor!

, anAnnouncementClass	^ AnnouncementSet with: self with: anAnnouncementClass!

asAnnouncement	^ self new!

handlesAnnouncement: anAnnouncement	"The receiver acts as a filter to determine whether subscribers who used the receiver as signaling tag (event identifier class or symbol) should receive incoming announcement. In particular, registering to a superclass will receive the announcements from all subclasses."	^ anAnnouncement class == self or: [ anAnnouncement class inheritsFrom: self ]!

systemIcon	^ Smalltalk ui icons iconNamed: #announcementIcon! !
!Announcement class categoriesFor: #,!public! !
!Announcement class categoriesFor: #asAnnouncement!converting!public! !
!Announcement class categoriesFor: #handlesAnnouncement:!public!testing! !
!Announcement class categoriesFor: #systemIcon!*Polymorph/Widgets/Themes!public! !

