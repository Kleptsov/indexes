"
Тестовый оъект

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	firstName:		<Object>
	patronymic:		<Object>
	surname:		<Object>


    Implementation Points
"
Class {
	#name : #ITestObject,
	#superclass : #Object,
	#instVars : [
		'surname',
		'firstName',
		'patronymic'
	],
	#category : #'Indexes-Test'
}

{ #category : #comparing }
ITestObject >> = aTestObject [
	self class = aTestObject class ifFalse: [ ^ false ].
	surname = aTestObject surname ifFalse: [ ^ false ].
	firstName = aTestObject firstName ifFalse: [ ^ false ].
	patronymic = aTestObject patronymic ifFalse: [ ^ false ].
	^ true.
	
]

{ #category : #accessing }
ITestObject >> firstName [
	^ firstName
]

{ #category : #accessing }
ITestObject >> firstName: anObject [
	firstName := anObject
]

{ #category : #accessing }
ITestObject >> patronymic [
	^ patronymic
]

{ #category : #accessing }
ITestObject >> patronymic: anObject [
	patronymic := anObject
]

{ #category : #accessing }
ITestObject >> surname [
	^ surname
]

{ #category : #accessing }
ITestObject >> surname: anObject [
	surname := anObject
]
