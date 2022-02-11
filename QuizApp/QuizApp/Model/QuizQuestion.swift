//
//  Question.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 10/02/22.
//

import Foundation

enum QuizQuestion<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
    
    var hashValue: Int {
        switch self {
        case .singleAnswer(let t):
            return t.hashValue
        case .multipleAnswer(let t):
            return t.hashValue
        }
    }
    
    static func ==<T>(lhs: QuizQuestion<T>, rhs: QuizQuestion<T>) -> Bool {
        switch (lhs, rhs) {
        case (.singleAnswer(let a), .singleAnswer(let b)):
            return a == b
        case (.multipleAnswer(let a), .multipleAnswer(let b)):
            return a == b
        default:
            return false
        }
    }
}
