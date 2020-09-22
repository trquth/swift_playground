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
let human = Human(name : "Crazy Man")
let fish = Fish(name: "Gold Fish")
let animals = [dog, human,fish]

