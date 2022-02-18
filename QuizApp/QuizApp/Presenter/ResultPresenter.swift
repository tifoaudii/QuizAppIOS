//
//  ResultPresenter.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 17/02/22.
//

import QuizEngineiOS

struct ResultPresenter {
    let result: QuizResult<QuizQuestion<String>, [String]>
    let questions: [QuizQuestion<String>]
    let correctAnswers: [QuizQuestion<String> : [String]]
    
    var quizSummary: String {
        return "You got \(result.score) from \(result.answer.count) correct answer"
    }
    
    var presentableAnswer: [PresentableAnswer] {
        questions.map { question in
            guard let userAnswer = result.answer[question],
                  let correctAnswer = correctAnswers[question] else {
                      fatalError("Correct answer should not be nil!")
                  }
            switch question {
            case .singleAnswer(let value), .multipleAnswer(let value):
                return PresentableAnswer(
                    answer: getFormattedCorrectAnswer(correctAnswer),
                    question: value,
                    wrongAnswer: getFormattedWrongAnswer(correctAnswer, userAnswer)
                )
            }
        }
    }
    
    
    private func getFormattedCorrectAnswer(_ correctAnswer: [String]) -> String {
        correctAnswer.joined(separator: ", ")
    }
    
    private func getFormattedWrongAnswer(_ correctAnswer: [String], _ answer: [String]) -> String? {
        return correctAnswer == answer ? nil : answer.joined(separator: ", ")
    }
}
