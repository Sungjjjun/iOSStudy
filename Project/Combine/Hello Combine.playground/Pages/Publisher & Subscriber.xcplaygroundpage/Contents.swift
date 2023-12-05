//: [Previous](@previous)

import Foundation
import Combine

// Publisher & Subscriber

// 데이터 하나만 보내는 Publisher(sink)
let just = Just(1_000)
let subscription1 = just.sink { value in
    print("Received Value From Just: \(value)")
}

// 여러개의 데이터를 보내는 Publisher(sink)
let arrayPublisher = [1, 2, 3, 4, 5].publisher
let subscription2 = arrayPublisher.sink(receiveValue: { value in
    print("Received Value From Array Publisher: \(value)")
})

// Assign
class MyClass {
    var property: Int = 0 {
        didSet{
            print("Did set property to \(property)")
        }
    }
}
let object = MyClass()
let subscription3 = arrayPublisher.assign(to: \.property, on: object)
print("Final Value: \(object.property)")
//object.property = 3
//: [Next](@next)
