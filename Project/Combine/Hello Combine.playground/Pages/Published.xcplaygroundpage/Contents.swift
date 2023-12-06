//: [Previous](@previous)

import Foundation
import UIKit
import Combine

final class SomeViewModel {
    @Published var name: String = "James"
    var age: Int = 20
}

final class Label {
    var text: String = ""
}

let label = Label()
let vm = SomeViewModel()

print(label.text)
vm.$name.assign(to: \.text, on: label)
print(label.text)

vm.name = "Nick"
print(label.text)
//: [Next](@next)
