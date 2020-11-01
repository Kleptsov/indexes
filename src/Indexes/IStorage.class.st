"
Хранилище коллекции и индексов к ней

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	collection:		<Object>
	indexes:		<Object>


    Implementation Points
"
Class {
	#name : #IStorage,
	#superclass : #Object,
	#instVars : [
		'collection',
		'indexes'
	],
	#category : #'Indexes-Core'
}

{ #category : #adding }
IStorage >> add: anObject [
	"добавление объекта к коллекции и обновление индексов"
	| stamp |
	collection add: anObject.
	indexes keysAndValuesDo: [ :k :v|
		stamp := k asExactStamp.
		(stamp normalizeFor: anObject) ifTrue: [
			v at: stamp ifAbsentPut: Set new.
			(v at: stamp) add: anObject ] ].
]

{ #category : #accessing }
IStorage >> collection [
	^ collection ifNil: [ collection := OrderedCollection new ]
]

{ #category : #accessing }
IStorage >> collection: anObject [
	collection := anObject
]

{ #category : #'index creating' }
IStorage >> createCommonIndex: anIndex [

	| d |
	^ indexes
		at: anIndex
		ifAbsent: [ d := Dictionary new.
						indexes at: anIndex put: d.
						self updateCommonIndex: anIndex.
						d yourself ].
]

{ #category : #accessing }
IStorage >> indexes [
	^ indexes
]

{ #category : #accessing }
IStorage >> indexes: anObject [
	indexes := anObject
]

{ #category : #initialization }
IStorage >> initialize [
	super initialize.
	indexes := Indexes new.
]

{ #category : #removing }
IStorage >> remove: anObject [
	"удалить объект из коллекции и индексы связанные с этим объектом"
	self removeIndexesOf: anObject.
	collection remove: anObject ifAbsent: [  ] .
]

{ #category : #removing }
IStorage >> remove: anObject ifAbsent: aBlock [
	"удалить объект из коллекции и индексы связанные с этим объектом"
	self removeIndexesOf: anObject.
	collection remove: anObject ifAbsent: aBlock.
]

{ #category : #removing }
IStorage >> removeAllIndexes [
	"удалить все индексы"
	
	indexes := Indexes new.
]

{ #category : #removing }
IStorage >> removeIndexesOf: anObject [
	"удалить индексы связанные с объектом"
	| exactStamp coll |
	indexes keysAndValuesDo: [ :k :v|
		exactStamp := k asExactStamp.
		(exactStamp normalizeFor: anObject)
			ifTrue: [ coll := v at: exactStamp ifAbsent: [ Set new ].
						coll remove: anObject ifAbsent: [  ] ] ]
]

{ #category : #enumerating }
IStorage >> select: aBlock [
	"выбрать объекты из коллекции, в основном уже индексированные,
	если нет индекса, то создается"
	
	| exactStamp commonStamp commonIndex |
	exactStamp := (IStampParser new parse: aBlock) asExactStamp.
	commonStamp := exactStamp asCommonStamp.
	commonIndex := indexes
						at: commonStamp
						ifAbsent: [ self createCommonIndex: commonStamp ].
	^ commonIndex
			at: exactStamp
			ifAbsent: [ Set new ].
]

{ #category : #accessing }
IStorage >> selectAndRemove: aBlock [
	"выбрать объекты из коллекции в основном индексированные
	и удалить из коллекции и из индекса"
	
	| res |
	res := self select: aBlock.
	res do: [ :el| self removeIndexesOf: el ].
	collection removeAll: res.
]

{ #category : #updating }
IStorage >> updateCommonIndex: anIndex [
	| exactIndex commonIndex |
	collection do: [ :el|
		exactIndex := anIndex asExactStamp.
		(exactIndex normalizeFor: el)
			ifTrue: [ commonIndex := indexes at: anIndex.
							(commonIndex at: exactIndex ifAbsentPut: Set new) add: el ] ]
]
