//: [Previous](@previous)

import Foundation
import Combine

// Basic CombineLatest -> 가장 최신인 값들 출력
let strPublisher = PassthroughSubject<String, Never>()
let intPublisher = PassthroughSubject<Int, Never>()

// 아래 코드와 동일
//Publishers.CombineLatest(strPublisher, intPublisher).sink { (str, int) in
//    print("Subscriber Received: \(str), \(int)")
//}

let subscription = strPublisher.combineLatest(intPublisher)
    .sink { (str, int) in
        print("Subscriber Received: \(str), \(int)")
    }
strPublisher.send("Hello")
intPublisher.send(11)
intPublisher.send(15)
strPublisher.send("Okay")

// Advanced CombineLatest
let namePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()
let subsription1 = namePublisher.combineLatest(passwordPublisher)
    .map { (name, password) -> Bool in
    return !name.isEmpty && !password.isEmpty && password.count >= 8
}
    .sink { valid in
    print("Credential Valid?? \(valid)")
}
namePublisher.send("Sung-Jun")
passwordPublisher.send("aaaaaa")
passwordPublisher.send("bbbbbbbb")

// Merge
let publisher1 = [1, 2, 3, 4, 5].publisher
let publisher2 = [100, 200, 300, 400].publisher

//아래 코드와 동일
//Publishers.Merge(publisher1, publisher2).sink { value in
//    print("Merged Publisher Received: \(value)")
//}

let subscription2 = publisher1
    .merge(with: publisher2).sink { value in
    print("Merged Publisher Received: \(value)")
    }

//: [Next](@next)
