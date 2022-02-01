//
//  Flow.swift
//  QuizEngine
//
//  Created by Tifo Audi Alif Putra on 31/01/22.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String : String])
}

final class Flow {
    
    private let router: Router
    private let questions: [String]
    private var result: [String : String] = [:]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeToNext(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
    }
    
    private func routeToNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] (answer: String) in
            guard let self = self else { return }
            self.result[question] = answer
            if let currentQuestionIndex = self.questions.firstIndex(of: question), currentQuestionIndex + 1 < self.questions.count {
                
                let nextQuestion = self.questions[currentQuestionIndex + 1]
                self.router.routeTo(question: nextQuestion, answerCallback: self.routeToNext(from: nextQuestion))
            } else {
                self.router.routeTo(result: self.result)
            }
        }
    }
}
