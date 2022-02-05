//
//  Router.swift
//  QuizEngine
//
//  Created by Tifo Audi Alif Putra on 05/02/22.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer: Equatable
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: QuizResult<Question, Answer>)
}
