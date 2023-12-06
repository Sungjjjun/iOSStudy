//: [Previous](@previous)

import Foundation
import Combine
import UIKit

// URLSessionTask Publisher and JSON Decoding Operator
struct SomeDecodable: Decodable {}
URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.google.com")!)
    .map { (data, response) in
    return data
    }
    .decode(type: SomeDecodable.self, decoder: JSONDecoder())

// Notifications
let center = NotificationCenter.default
let noti = Notification.Name("MyNoti")
let notiPublisher = center.publisher(for: noti, object: nil)
let subscriptionNoti = notiPublisher.sink { _ in
    print("Notification Received")
}
center.post(name: noti, object: nil)
subscriptionNoti.cancel()

// KeyPath binding to NSObject instances
let ageLabel = UILabel()
print(ageLabel.text)
Just(28)
    .map { age in
        return "Age is \(age)"
    }
    .assign(to: \.text, on: ageLabel)
print(ageLabel.text!)

// Timer
// autoconnect 를 이용하면 subscribe 되면 바로 시작함
let timerPublisher = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

let subscriptionTimer = timerPublisher.sink { time in
    print("Time is \(time)")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    subscriptionTimer.cancel()
}
//: [Next](@next)
