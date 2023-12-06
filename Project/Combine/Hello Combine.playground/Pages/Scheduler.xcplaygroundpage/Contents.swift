//: [Previous](@previous)

import Foundation
import Combine

let arrayPublisher = [1, 2, 3, 4, 5].publisher
let queue = DispatchQueue(label: "MyQueue")
let subscription1 = arrayPublisher
    .subscribe(on: queue)
    .map({ value -> Int in
        print("Tranform: \(value), Thread: \(Thread.current)")
        return value
    })
    .receive(on: DispatchQueue.main)
    .sink { value in
        print("Subscriber received: \(value), Thread: \(Thread.current)")
}
//: [Next](@next)
