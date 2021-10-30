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
	|ks index |
	ks := self result
		at: keySource
		ifAbsentPut: [ Dictionary new ].
	index := ks at: indexes ifAbsentPut: [ Set new ].
	index add: val.
]

{ #category : #building }
IKeyBuilder >> buildIndexes [
	| keySourceDict indexSet |
	
	keySourceDict := self result at: keySource ifAbsentPut: [ Dictionary new ].
	indexes do: [ :index|
		indexSet := keySourceDict at: index ifAbsentPut: [ Set new ].
		indexSet add: val.
	]
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
