Class {
	#name : #IKeyBuilder,
	#superclass : #Object,
	#instVars : [
		'indexes',
		'indexName',
		'keySource',
		'indexValue',
		'result',
		'forRemoved'
	],
	#category : #'Indexes-Core'
}

{ #category : #building }
IKeyBuilder class >> indexName: aKeySource index: anIndex value: aValue [ 
	^ self new
		indexName: aKeySource;
		indexValue: aValue;
		indexes: anIndex;
		build
]

{ #category : #building }
IKeyBuilder class >> indexName: anIndexName value: aValue [
	^ self new
		indexName: anIndexName;
		indexValue: aValue;
		build
]

{ #category : #building }
IKeyBuilder >> build [
	indexes ifNil: [ indexes := indexValue perform: self indexName ].
	(indexes class isKindOf: SequenceableCollection)
		ifTrue: [self buildIndexes] ifFalse: [ self buildIndex ].
	^ result
]

{ #category : #building }
IKeyBuilder >> buildForRemovedIndex [
	| dict set |
	dict := self forRemoved at: indexValue ifAbsentPut: [ Dictionary new ].
	set := dict at: indexName ifAbsentPut: [ Set new ].
	set add: indexes.
]

{ #category : #building }
IKeyBuilder >> buildForRemovedIndexes [
	| dict set |
	dict := self forRemoved at: indexValue ifAbsentPut: [ Dictionary new ].
	set := dict at: indexName ifAbsentPut: [ Set new ].
	set addAll: indexes.
]

{ #category : #building }
IKeyBuilder >> buildIndex [
	|dict index |
	dict := self result
		at: indexName
		ifAbsentPut: [ Dictionary new ].
	index := dict at: indexes ifAbsentPut: [ Set new ].
	index add: indexValue.
	self buildForRemovedIndex.
]

{ #category : #building }
IKeyBuilder >> buildIndexes [
	| dict indexSet |
	
	dict := self result at: indexName ifAbsentPut: [ Dictionary new ].
	indexes do: [ :index|
		indexSet := dict at: index ifAbsentPut: [ Set new ].
		indexSet add: indexValue.
	].
	self buildForRemovedIndexes.
]

{ #category : #accessing }
IKeyBuilder >> forRemoved [

	^ forRemoved ifNil: [ forRemoved := IdentityDictionary new ]
]

{ #category : #accessing }
IKeyBuilder >> forRemoved: anObject [

	forRemoved := anObject
]

{ #category : #accessing }
IKeyBuilder >> indexName [

	^ indexName
]

{ #category : #accessing }
IKeyBuilder >> indexName: anObject [

	indexName := anObject asSymbol
]

{ #category : #accessing }
IKeyBuilder >> indexValue [

	^ indexValue
]

{ #category : #accessing }
IKeyBuilder >> indexValue: anObject [

	indexValue := anObject
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
IKeyBuilder >> result [
	^ result ifNil: [ result := Dictionary new ]
]

{ #category : #accessing }
IKeyBuilder >> result: anObject [

	result := anObject
]
