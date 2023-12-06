//: [Previous](@previous)

import Foundation
import Combine

let subject = PassthroughSubject<String, Never>()
// The print() operator prints you all lifecycle events
let subscription = subject
    .print("[Debug]")
    .sink { value in
    print("Subscriber received value: \(value)")
}
subject.send("Hello")
subject.send("Everyone")

// Publisher가 관계 끝냄
//subject.send(completion: .finished)

// Subscriber가 관계 끝냄
subscription.cancel()

subject.send("Hello, Are you there??")

//: [Next](@next)
