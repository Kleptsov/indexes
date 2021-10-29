Class {
	#name : #IKeyBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'Indexes-Test'
}

{ #category : #'as yet unclassified' }
IKeyBuilderTest >> setUp [
	builder := IKeyBuilder new.
]

{ #category : #'as yet unclassified' }
IKeyBuilderTest >> testBuildIndex [
	builder keySource: #asString.
	builder val: 'value'.
	builder indexes: 'value'.
	builder buildIndex.
	self assert: (builder result at: #asString) class equals: IdentityDictionary.
	self assert: (((builder result at: #asString) at: 'value') like: 'value') equals: 'value'.
]

{ #category : #'as yet unclassified' }
IKeyBuilderTest >> testBuildIndexes [
	
]
