Extension { #name : #Object }

{ #category : #'*Indexes' }
Object >> commonEqual: anObject [
	^ self = anObject
]

{ #category : #'*Indexes' }
Object >> commonStampString [
	^ self asString
]

{ #category : #'*Indexes' }
Object >> exactEqual: anObject [
	^ self = anObject
]

{ #category : #'*Indexes' }
Object >> exactStampString [
	^ self asString
]

{ #category : #'*Indexes' }
Object >> normalizeFor: aRootObject receiver: anObject [
	^ self
]

{ #category : #'*Indexes' }
Object >> sendTo: anObject rootReceiver: aRootObject [
	^ self
]
