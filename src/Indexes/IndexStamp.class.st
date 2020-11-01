"
Печать индексированного сообщения

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	messages:		<Object>
	sender:		<Object>


    Implementation Points
"
Class {
	#name : #IndexStamp,
	#superclass : #Object,
	#instVars : [
		'messages'
	],
	#category : #'Indexes-Stamp'
}

{ #category : #parsing }
IndexStamp >> = anObject [
	self addMessage: (IndexMessage selector: #= arguments: {anObject})
]

{ #category : #parsing }
IndexStamp >> addMessage: aMessage [
	| indexMessage |
	indexMessage := IndexMessage
		selector: aMessage selector
		arguments: aMessage arguments.
	messages add: indexMessage.
]

{ #category : #converting }
IndexStamp >> asCommonStamp [
	^ ICommonStamp new
			indexStamp: self clone;
			yourself.
]

{ #category : #converting }
IndexStamp >> asExactStamp [
	^ IExactStamp new
			indexStamp: self clone;
			yourself.
]

{ #category : #cloning }
IndexStamp >> clone [
	| new ms|
	new := self class new.
	ms := messages collect: [ :m|
		m clone ].
	new messages: ms.
	^ new.
]

{ #category : #comparing }
IndexStamp >> commonEqual: anIndexStamp [
	| size |
	self class = anIndexStamp class ifFalse: [ ^ false ].
	size := messages size.
	size = anIndexStamp messages size ifFalse: [ ^ false ].
	1 to: size do: [ :index|
		((messages at: index) commonEqual: (anIndexStamp messages at: index))
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #comparing }
IndexStamp >> commonHash [
	^ self commonStampString hash.
]

{ #category : #printing }
IndexStamp >> commonStampString [
	|str|
	str := '(', self class asString, '('.
	messages do: [ :el|
		str := str, el commonStampString ].
	str := str, '))'.
	^ str
]

{ #category : #parsing }
IndexStamp >> doesNotUnderstand: aMessage [
	self addMessage: aMessage
]

{ #category : #comparing }
IndexStamp >> exactEqual: anIndexStamp [
	| size |
	self class = anIndexStamp class ifFalse: [ ^ false ].
	size := messages size.
	size = anIndexStamp messages size ifFalse: [ ^ false ].
	1 to: size do: [ :index|
		((messages at: index) exactEqual: (anIndexStamp messages at: index))
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #comparing }
IndexStamp >> exactHash [
	^ self exactStampString hash
]

{ #category : #printing }
IndexStamp >> exactStampString [
	|str|
	str := '(', self class asString, '('.
	messages do: [ :el|
		str := str, el exactStampString ].
	str := str, '))'.
	^ str
]

{ #category : #initialization }
IndexStamp >> initialize [
	super initialize.
	messages := OrderedCollection new.
]

{ #category : #accessing }
IndexStamp >> messages [
	^ messages
]

{ #category : #accessing }
IndexStamp >> messages: anObject [
	messages := anObject
]

{ #category : #transforming }
IndexStamp >> normalizeFor: anObject [
	^ self normalizeFor: anObject receiver: anObject.
]

{ #category : #transforming }
IndexStamp >> normalizeFor: aRootObject receiver: anObject [
	| obj |
	obj := anObject.
	messages do: [ :m|
		obj := m normalizeFor: aRootObject receiver: obj ].
	^ obj.
]

{ #category : #printing }
IndexStamp >> printString [
	^ self exactStampString
]

{ #category : #transforming }
IndexStamp >> sendTo: anObject [
	^ self sendTo: anObject rootReceiver: anObject.
]

{ #category : #transforming }
IndexStamp >> sendTo: anObject rootReceiver: aRootObject [
	| obj |
	obj := anObject.
	messages do: [ :m|
		obj := m sendTo: obj rootReceiver: aRootObject ].
	^ obj.
]
