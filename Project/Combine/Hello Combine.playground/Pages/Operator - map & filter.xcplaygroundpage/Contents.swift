//: [Previous](@previous)

import Foundation
import Combine

// Transform - Map
let numPublisher = PassthroughSubject<Int, Never>()
let subscription1 = numPublisher
    .map{ $0 * 2}
    .sink { value in
    print("Subscription Received: \(value)")
}
numPublisher.send(10)
subscription1.cancel()

// Filter
let stringPublisher = PassthroughSubject<String, Never>()
let subscription2 = stringPublisher
    .filter { string in return string.contains("a") }
    .sink { value in
        print("Subscription2 Received: \(value)")
    }
stringPublisher.send("Ananymous")
stringPublisher.send("Send")
stringPublisher.send(completion: .finished)
//: [Next](@next)
