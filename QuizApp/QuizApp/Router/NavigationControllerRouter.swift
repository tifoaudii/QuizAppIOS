//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 06/02/22.
//

import UIKit
import QuizEngineiOS

final class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(result: QuizResult<QuizQuestion<String>, [String]>) {
        let viewController = factory.resultViewController(for: result)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeTo(question: QuizQuestion<String>, answerCallback: @escaping ([String]) -> Void) {
        switch question {
        case .singleAnswer(_):
            let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
            navigationController.pushViewController(viewController, animated: true)
        case .multipleAnswer(_):
            let barButtonItem = UIBarButtonItem(title: "Submit", style: .done, target: nil, action: nil)
            let buttonController = ButtonController(barButtonItem, answerCallback)
            let viewController = factory.questionViewController(for: question, answerCallback: { answers in
                buttonController.update(answers)
            })

            viewController.navigationItem.rightBarButtonItem = buttonController.button
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}


private class ButtonController: NSObject {
    
    let button: UIBarButtonItem
    let action: (([String]) -> Void)
    
    private var model: [String] = []
    
    init(_ button: UIBarButtonItem, _ action: @escaping (([String]) -> Void)) {
        self.button = button
        self.action = action
        super.init()
        configureButton()
        onModelUpdated()
    }
    
    func update(_ model: [String]) {
        self.model = model
        onModelUpdated()
    }
    
    private func configureButton() {
        button.target = self
        button.action = #selector(actionCalled)
    }
    
    private func onModelUpdated() {
        button.isEnabled = model.count > 0
    }
    
    @objc private func actionCalled() {
        action(model)
    }
}
