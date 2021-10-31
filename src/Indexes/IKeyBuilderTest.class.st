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
IKeyBuilderTest >> testBuildForRemovedIndex [
	builder indexName: #asString.
	builder indexValue: 'value'.
	builder indexes: 'value'.
	builder buildForRemovedIndex.
	self assert: (builder forRemoved at: builder indexValue) class equals: Dictionary.
	self assert: (((builder forRemoved at: builder indexValue) at: #asString) like: 'value') equals: 'value'.
]

{ #category : #tests }
IKeyBuilderTest >> testBuildForRemovedIndexes [
	builder indexName: #asString.
	builder indexValue: 'value'.
	builder indexes: {'1'. '2'. '3'. '4'}.
	builder buildForRemovedIndexes.
	self assert: (builder forRemoved at: builder indexValue) class equals: Dictionary.
	self assert: (((builder forRemoved at: builder indexValue) at: #asString) like: '1') equals: '1'.
	self assert: (((builder forRemoved at: builder indexValue) at: #asString) like: '3') equals: '3'.
	self assert: (((builder forRemoved at: builder indexValue) at: #asString) size) equals: 4.
]

{ #category : #tests }
IKeyBuilderTest >> testBuildIndex [
	builder indexName: #asString.
	builder indexValue: 'value'.
	builder indexes: 'value'.
	builder buildIndex.
	self assert: (builder result at: #asString) class equals: Dictionary.
	self assert: (((builder result at: #asString) at: 'value') like: 'value') equals: 'value'.
]

{ #category : #tests }
IKeyBuilderTest >> testBuildIndexes [
	builder indexName: #asString.
	builder indexValue: 'string'.
	builder indexes: {'1'. '2'. '3'. '4'}.
	builder buildIndexes.
	self assert: (builder result at: #asString) class equals: Dictionary.
	self assert: (((builder result at: #asString) at: '1') like: 'string') equals: 'string'.
	self assert: (((builder result at: #asString) at: '3') like: 'string') equals: 'string'.
]
