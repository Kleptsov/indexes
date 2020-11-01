"
Хранилище индексов. Представляет из себя словарь, где в качестве ключей выступает общий индекс а значением словарь ассоциаций (точный индекс -> Set коллекция индексированных объектов)

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #Indexes,
	#superclass : #Dictionary,
	#category : #'Indexes-Core'
}

{ #category : #testing }
Indexes >> isConform: anElement [
	"соответствует ли элемент этому индексу"
]
