import Foundation
import Combine

// PassthroughSubject
let relay = PassthroughSubject<String, Never>()
let subscription1 = relay.sink { value in
    print("Subscription1 received value: \(value)")
}
relay.send("Hello")
relay.send("World!!!!")

// CurrentValueSubject
let variable = CurrentValueSubject<String, Never>("Default") // CurrentValueSubject는 초기값이 필요
variable.send("Initial Data")
let subscription2 = variable.sink { value in
    print("Subscription2 received value: \(value)")
}
variable.send("Hello")
variable.send("World!!!")
variable.value

// relay.send("Here")
// relay.send("We")
// relay.send("Go")
let publisher = ["Here", "We", "Go"].publisher
publisher.subscribe(relay)
