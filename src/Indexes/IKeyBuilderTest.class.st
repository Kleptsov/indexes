Class {
	#name : #IKeyBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'Indexes-Test'
}

{ #category : #tests }
IKeyBuilderTest >> setUp [
	builder := IKeyBuilder new.
]

{ #category : #tests }
IKeyBuilderTest >> testBuildIndex [
	builder keySource: #asString.
	builder val: 'value'.
	builder indexes: 'value'.
	builder buildIndex.
	self assert: (builder result at: #asString) class equals: Dictionary.
	self assert: (((builder result at: #asString) at: 'value') like: 'value') equals: 'value'.
]

{ #category : #tests }
IKeyBuilderTest >> testBuildIndexes [
	builder keySource: #asString.
	builder val: 'string'.
	builder indexes: {'1'. '2'. '3'. '4'}.
	builder buildIndexes.
	self assert: (builder result at: #asString) class equals: Dictionary.
	self assert: (((builder result at: #asString) at: '1') like: 'string') equals: 'string'.
	self assert: (((builder result at: #asString) at: '3') like: 'string') equals: 'string'.
]
