//: [Previous](@previous)

import Foundation

class Animal {
    var name : String
    init(name : String) {
        self.name = name
    }
}


class Dog: Animal {
    func run() {
        print("running")
    }
}

class Human : Animal {
    func walk() {
        print("walking")
    }
}

class Fish : Animal {
    func swim()  {
        print("swimming")
    }
}

let dog = Dog(name : "PitBull")
let people = Human(name : "Crazy Man")
let goldFish = Fish(name: "Gold Fish")

if goldFish is Fish {
    print("This is fish")
}

if goldFish is Animal {
    print("Fish is also animal")
}

if people is Fish {
    print("People is fish")
}else{
    print("People is not fish")
}

print("---------------forced downcast -----------------")

//Mark : Cast object from base class type to subclass type

let animals = [dog, people, goldFish]
for animal in animals {
    if animal is Fish {
        //animal.swim() wrong
        // has to cast to correct
        
        let fish = animal as! Fish
        fish.swim()
    }
}

print("-------------------- casting-------------------")
//let smallDog = animals[0] as? Dog
//smallDog?.run()
//or
if let smallDog = animals[0] as? Dog {
    smallDog.run()
}else{
    print("Casting has failed")
}


var woman : Human?
//woman = nil
woman = Human(name: "Truc")
woman?.walk()
 

print("--------------------Any/AnyObject/NSObject-----------------------------")
