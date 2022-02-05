//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by Tifo Audi Alif Putra on 05/02/22.
//

import Foundation
import QuizEngineiOS

class RouterSpy: Router {
    var questions: [String] = []
    var result: QuizResult<String, String>?
    var answerCallback: ((String) -> Void) = { _ in }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        questions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: QuizResult<String, String>) {
        self.result = result
    }
}
