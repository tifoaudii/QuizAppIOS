//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 18/02/22.
//

import Foundation

struct QuestionPresenter {
    let questions: [QuizQuestion<String>]
    let question: QuizQuestion<String>
    
    var title: String {
        guard let index = questions.firstIndex(of: question) else {
            return ""
        }
        
        return "Question #\(index + 1)"
    }
}
