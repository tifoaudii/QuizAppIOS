//
//  Flow.swift
//  QuizEngine
//
//  Created by Tifo Audi Alif Putra on 31/01/22.
//

import Foundation

final class Flow<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    
    private let router: R
    private let questions: [Question]
    private var answers: [Question : Answer] = [:]
    private var score: ([Question: Answer]) -> Int
    
    init(questions: [Question], router: R, score: @escaping ([Question: Answer]) -> Int) {
        self.questions = questions
        self.router = router
        self.score = score
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeToNext(from: firstQuestion))
        } else {
            router.routeTo(result: getQuizResult())
        }
    }
    
    private func routeToNext(from question: Question) -> (Answer) -> Void {
        return { [weak self] (answer: Answer) in
            guard let self = self else { return }
            self.answers[question] = answer
            if let currentQuestionIndex = self.questions.firstIndex(of: question), currentQuestionIndex + 1 < self.questions.count {
                
                let nextQuestion = self.questions[currentQuestionIndex + 1]
                self.router.routeTo(question: nextQuestion, answerCallback: self.routeToNext(from: nextQuestion))
            } else {
                self.router.routeTo(result: self.getQuizResult())
            }
        }
    }
    
    private func getQuizResult() -> QuizResult<Question, Answer> {
        QuizResult(answer: answers, score: score(answers))
    }
}
