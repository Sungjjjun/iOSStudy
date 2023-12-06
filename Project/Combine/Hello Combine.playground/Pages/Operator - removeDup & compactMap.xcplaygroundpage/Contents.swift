//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

// removeDuplicates -> 중복된 데이터는 제거하고 저장
let words = "hey hey hey there! Mr Mr ?"
    .components(separatedBy: " ")
    .publisher
words
    .removeDuplicates()
    .sink { value in
        print("Remove Duplicated Data: \(value)")
    }
    .store(in: &subscriptions)

// compactMap -> 다양한 자료형의 데이터를 한가지의 데이터 형으로 변환하여 저장(변환이 안되는 것은 nil)
let strings = ["a", "1.24", "3", "def", "45", "0.23"].publisher
strings
    .compactMap { value in
        return Float(value)
    }
    .sink { float in
        print("Compact Map Float Data: \(float)")
    }
    .store(in: &subscriptions)

// ignoreOutput -> 데이터의 한계 개수가 되지 않았지만, 데이터를 그만 받을 떄
let numbers = (1...10_000).publisher
numbers
    .ignoreOutput()
    .sink(receiveCompletion: {print("Completed with: \($0)")},
          receiveValue: {print($0)})
    .store(in: &subscriptions)

// prefix -> 특정 개수의 데이터만 받고, 끝냄
let tens = (1...10).publisher
tens
    .prefix(2)
    .sink(receiveCompletion: {print("Completed with: \($0)")},
          receiveValue: {print($0)})
    .store(in: &subscriptions)

// append
let number = (0...10).publisher
let otherNumbers = (5...35).publisher
number
    .append(otherNumbers)
    .sink { print("\($0)", terminator: ", ") }
    .store(in: &subscriptions)

//: [Next](@next)
