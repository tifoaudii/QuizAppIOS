//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 06/02/22.
//

import UIKit
import QuizEngineiOS

protocol ViewControllerFactory {
    func questionViewController(for question: QuizQuestion<String>, answerCallback: @escaping (String) -> Void) -> UIViewController
    func resultViewController(for result: QuizResult<QuizQuestion<String>, String>) -> UIViewController
}

final class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(result: QuizResult<QuizQuestion<String>, String>) {
        let viewController = factory.resultViewController(for: result)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeTo(question: QuizQuestion<String>, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
        navigationController.pushViewController(viewController, animated: true)
    }
}
