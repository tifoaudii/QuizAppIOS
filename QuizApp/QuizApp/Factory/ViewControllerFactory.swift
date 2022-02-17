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
    
    private let options: [QuizQuestion<String>: [String]]
    
    init(options: [QuizQuestion<String>: [String]]) {
        self.options = options
    }
    
    func questionViewController(for question: QuizQuestion<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("Couldn't create view controller with options nil")
        }
        switch question {
        case .singleAnswer(let value):
            return QuestionViewController(question: value, options: options, selection: answerCallback)
        case .multipleAnswer(let value):
            let questionViewController = QuestionViewController(question: value, options: options, isMultipleAnswer: true, selection: answerCallback)
            return questionViewController
        }
        
    }
    
    func resultViewController(for result: QuizResult<QuizQuestion<String>, [String]>) -> UIViewController {
        UIViewController()
    }
}
