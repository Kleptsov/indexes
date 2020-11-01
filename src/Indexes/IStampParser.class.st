"
Парсер индексируемого сообщения

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #IStampParser,
	#superclass : #Object,
	#category : #'Indexes-Stamp'
}

{ #category : #parsing }
IStampParser >> = anObject [
	^ self addMessage: (Message selector: #= arguments: {anObject})
]

{ #category : #parsing }
IStampParser >> addMessage: aMessage [
	^ IndexStamp new addMessage: aMessage
]

{ #category : #parsing }
IStampParser >> doesNotUnderstand: aMessage [
	^ self addMessage: aMessage
]

{ #category : #parsing }
IStampParser >> parse: aBlock [
	^ aBlock value: self.
]
