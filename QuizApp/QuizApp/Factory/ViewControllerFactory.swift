//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 15/02/22.
//

import UIKit
import QuizEngineiOS

protocol ViewControllerFactory {
    func questionViewController(for question: QuizQuestion<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController
    func resultViewController(for result: QuizResult<QuizQuestion<String>, [String]>) -> UIViewController
}

final class IOSViewControllerFactory: ViewControllerFactory {
    
    private let questions: [QuizQuestion<String>]
    private let options: [QuizQuestion<String>: [String]]
    
    init(questions: [QuizQuestion<String>], options: [QuizQuestion<String>: [String]]) {
        self.options = options
        self.questions = questions
    }
    
    func questionViewController(for question: QuizQuestion<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("Couldn't create view controller with options nil")
        }
        switch question {
        case .singleAnswer(let value):
            return createQuestionViewController(for: question, value: value, options: options, isMultipleAnswer: false, selection: answerCallback)
        case .multipleAnswer(let value):
            return createQuestionViewController(for: question, value: value, options: options, isMultipleAnswer: true, selection: answerCallback)
        }
        
    }
    
    func resultViewController(for result: QuizResult<QuizQuestion<String>, [String]>) -> UIViewController {
        UIViewController()
    }
    
    private func createQuestionViewController(for question: QuizQuestion<String>, value: String, options: [String], isMultipleAnswer: Bool, selection: @escaping ([String]) -> Void) -> QuestionViewController {
        let questionViewController = QuestionViewController(question: value, options: options, isMultipleAnswer: isMultipleAnswer, selection: selection)
        questionViewController.title = QuestionPresenter(questions: questions, question: question).title
        return questionViewController
    }
}
