Class {
	#name : #IKeyBuilder,
	#superclass : #Object,
	#instVars : [
		'indexes',
		'keySource',
		'val',
		'result'
	],
	#category : #'Indexes-Core'
}

{ #category : #building }
IKeyBuilder class >> keySource: aKeySource value: aValue [
	^ self new
		keySource: aKeySource;
		val: aValue;
		buildIndexes;
		result
]

{ #category : #building }
IKeyBuilder class >> keySource: aKeySource value: aValue indexes: someIndexes [
	^ self new
		keySource: aKeySource;
		val: aValue;
		result: someIndexes;
		buildIndexes;
		result
]

{ #category : #building }
IKeyBuilder >> build [
	indexes := val perform: keySource asSymbol.
	(indexes class isKindOf: SequenceableCollection)
		ifTrue: [self buildIndexes] ifFalse: [ self buildIndex ].
	^ result
]

{ #category : #building }
IKeyBuilder >> buildIndex [
	self result
		at: indexes
		ifAbsent: [ result at: keySource put: IdentitySet new ].
	(result at: keySource) add: val.
]

{ #category : #building }
IKeyBuilder >> buildIndexes [
	| s |
	s := self result at: keySource ifAbsent: [ result at: keySource put: IdentitySet new ].
	s addAll: indexes.
]

{ #category : #accessing }
IKeyBuilder >> indexes [

	^ indexes
]

{ #category : #accessing }
IKeyBuilder >> indexes: anObject [

	indexes := anObject
]

{ #category : #accessing }
IKeyBuilder >> keySource [

	^ keySource
]

{ #category : #accessing }
IKeyBuilder >> keySource: anObject [

	keySource := anObject
]

{ #category : #accessing }
IKeyBuilder >> result [
	^ result ifNil: [ result := Dictionary new ]
]

{ #category : #accessing }
IKeyBuilder >> result: anObject [

	result := anObject
]

{ #category : #accessing }
IKeyBuilder >> val [

	^ val
]

{ #category : #accessing }
IKeyBuilder >> val: anObject [

	val := anObject
]
