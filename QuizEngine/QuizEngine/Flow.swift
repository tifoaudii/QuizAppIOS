//
//  Flow.swift
//  QuizEngine
//
//  Created by Tifo Audi Alif Putra on 31/01/22.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: [Question : Answer])
}

final class Flow<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    
    private let router: R
    private let questions: [Question]
    private var result: [Question : Answer] = [:]
    
    init(questions: [Question], router: R) {
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
    
    private func routeToNext(from question: Question) -> (Answer) -> Void {
        return { [weak self] (answer: Answer) in
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
