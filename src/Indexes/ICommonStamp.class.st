"
Общая печать индексированного сообщения, в отличии от 

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
	#name : #ICommonStamp,
	#superclass : #Object,
	#instVars : [
		'indexStamp'
	],
	#category : #'Indexes-Stamp'
}

{ #category : #comparing }
ICommonStamp >> = anIndexStamp [
	^ indexStamp commonEqual: anIndexStamp indexStamp
]

{ #category : #converting }
ICommonStamp >> asCommonStamp [
	^ self class new
			indexStamp: indexStamp clone;
			yourself.
]

{ #category : #converting }
ICommonStamp >> asExactStamp [
	^ IExactStamp new
			indexStamp: indexStamp clone;
			yourself.
]

{ #category : #printing }
ICommonStamp >> asString [
	^ self printString
]

{ #category : #cloning }
ICommonStamp >> clone [
	| stamp |
	stamp := self shallowCopy.
	stamp indexStamp: indexStamp clone.
	^ stamp
]

{ #category : #comparing }
ICommonStamp >> hash [
	^ indexStamp commonHash
]

{ #category : #accessing }
ICommonStamp >> indexStamp [
	^ indexStamp
]

{ #category : #accessing }
ICommonStamp >> indexStamp: anObject [
	indexStamp := anObject
]

{ #category : #transforming }
ICommonStamp >> normalizeFor: anObject [
	indexStamp normalizeFor: anObject rootObject: anObject.
]

{ #category : #printing }
ICommonStamp >> printString [
	^ indexStamp commonStampString
]
