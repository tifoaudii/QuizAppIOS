//
//  QuizResultHelper.swift
//  QuizAppTests
//
//  Created by Tifo Audi Alif Putra on 17/02/22.
//

@testable import QuizEngineiOS

extension QuizResult: Hashable {
    public static func == (lhs: QuizResult<Question, Answer>, rhs: QuizResult<Question, Answer>) -> Bool {
        lhs.score == rhs.score
    }
    
    static func createMock(answer: [Question : Answer] = [:], score: Int = 0) -> QuizResult<Question, Answer> {
        .init(answer: answer, score: score)
    }
    
    public var hashValue: Int {
        1
    }
}
