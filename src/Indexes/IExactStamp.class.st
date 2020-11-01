"
Точная печать индексированного сообщения

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	indexStamp:		<Object>


    Implementation Points
"
Class {
	#name : #IExactStamp,
	#superclass : #Object,
	#instVars : [
		'indexStamp'
	],
	#category : #'Indexes-Stamp'
}

{ #category : #comparing }
IExactStamp >> = anExactIndex [
	^ indexStamp exactEqual: anExactIndex indexStamp.
]

{ #category : #converting }
IExactStamp >> asCommonStamp [
	^ ICommonStamp new
			indexStamp: indexStamp clone;
			yourself.
]

{ #category : #converting }
IExactStamp >> asExactStamp [
	^ self class new
			indexStamp: indexStamp clone;
			yourself
]

{ #category : #printing }
IExactStamp >> asString [
	^ self printString.
]

{ #category : #cloning }
IExactStamp >> clone [
	| stamp |
	stamp := self shallowCopy.
	stamp indexStamp: indexStamp clone.
	^ stamp
]

{ #category : #comparing }
IExactStamp >> hash [
	^ indexStamp exactHash
]

{ #category : #accessing }
IExactStamp >> indexStamp [
	^ indexStamp
]

{ #category : #accessing }
IExactStamp >> indexStamp: anObject [
	indexStamp := anObject
]

{ #category : #transforming }
IExactStamp >> normalizeFor: anObject [
	^ indexStamp normalizeFor: anObject receiver: anObject.
]

{ #category : #printing }
IExactStamp >> printString [
	^ indexStamp exactStampString
]
