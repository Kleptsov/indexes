"
Хранилище индексированного сообщения,  включает специальный протокол сравнения и хеша

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	arguments:		<Object>
	selector:		<Object>


    Implementation Points
"
Class {
	#name : #IndexMessage,
	#superclass : #Object,
	#instVars : [
		'selector',
		'arguments'
	],
	#category : #'Indexes-Stamp'
}

{ #category : #'instance creation' }
IndexMessage class >> selector: anSelector arguments: anArray [
	^ self new
			selector: anSelector;
			arguments: anArray;
			yourself.
]

{ #category : #accessing }
IndexMessage >> arguments [
	^ arguments
]

{ #category : #accessing }
IndexMessage >> arguments: anObject [
	arguments := anObject
]

{ #category : #cloning }
IndexMessage >> clone [
	| new args |
	new := self class new.
	new selector: selector.
	arguments ifNil: [ ^ new ].
	args := arguments collect: [ :arg|
		arg clone ].
	new arguments: args.
	^ new
]

{ #category : #comparing }
IndexMessage >> commonEqual: anIndexMessage [
	| size arg1 arg2 |
	selector = anIndexMessage selector ifFalse: [ ^ false ].
	selector = #= ifTrue: [ ^ true ].
	size := anIndexMessage arguments size.
	size = arguments size ifFalse: [ ^ false. ].
	1 to: size do: [ :index|
		arg1 := anIndexMessage arguments at: index.
		arg2 := arguments at: index.
		(arg1 commonEqual: arg2) ifFalse: [ ^ false ].
	].
	^ true
]

{ #category : #comparing }
IndexMessage >> commonStampString [
	| str |
	selector = #= ifTrue: [ ^ '(selector(=))' ].
	str := self class asString, '(selector(', selector asString, ')'.
	arguments do: [ :el|
		str := str, '(arg(', el commonStampString, '))' ].
	str := str, ')'.
	^ str
]

{ #category : #comparing }
IndexMessage >> exactEqual: anIndexMessage [
	| size arg1 arg2 |
	selector = anIndexMessage selector ifFalse: [ ^ false ].
	size := anIndexMessage arguments size.
	size = arguments size ifFalse: [ ^ false. ].
	1 to: size do: [ :index|
		arg1 := anIndexMessage arguments at: index.
		arg2 := arguments at: index.
		(arg1 exactEqual: arg2) ifFalse: [ ^ false ].
	].
	^ true
]

{ #category : #comparing }
IndexMessage >> exactStampString [
	| str |
	str := self class asString, '(selector(', selector asString, ')'.
	arguments do: [ :el|
		str := str, '(arg(', el exactStampString, '))' ].
	str := str, ')'.
	^ str
]

{ #category : #transforming }
IndexMessage >> normalizeFor: aRootObject receiver: anObject [
	| res args|
	selector = #= ifTrue: [ arguments := { anObject } ].
	(arguments size = 0)
		ifTrue: [ 	res := anObject perform: selector asSymbol ]
		ifFalse: [ 	args := arguments collect: [ :arg|
							arg normalizeFor: aRootObject receiver: aRootObject ].
						res := anObject perform: selector asSymbol withArguments: args. ].
	^ res
]

{ #category : #accessing }
IndexMessage >> selector [
	^ selector
]

{ #category : #accessing }
IndexMessage >> selector: anObject [
	selector := anObject
]

{ #category : #transforming }
IndexMessage >> sendTo: anObject rootReceiver: aRootObject [
	| res args|
	(arguments size = 0)
		ifTrue: [ 	res := anObject perform: selector asSymbol ]
		ifFalse: [ 	args := arguments collect: [ :arg|
							arg sendTo: aRootObject rootReceiver: aRootObject ].
						res := anObject perform: selector asSymbol withArguments: args. ].
	^ res
]
