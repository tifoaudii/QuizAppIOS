//
//  Quiz.swift
//  QuizEngine
//
//  Created by Tifo Audi Alif Putra on 05/02/22.
//

import Foundation

public class QuizCoordinator<
    Question,
    Answer,
    R: Router
> where R.Question == Question, R.Answer == Answer {
    
    private let flow: Flow<Question, Answer, R>
    private let questions: [Question]
    private let router: R
    
    public init(questions: [Question], router: R, correctAnswers: [Question : Answer]) {
        self.questions = questions
        self.router = router
        self.flow = Flow(questions: questions, router: router, score: { (answer: [Question : Answer]) in
            var score: Int = 0
            correctAnswers.keys.forEach {
                if answer[$0] == correctAnswers[$0] { score += 1 }
            }
            return score
        })
    }
    
    public func startQuiz() {
        flow.start()
    }
}
