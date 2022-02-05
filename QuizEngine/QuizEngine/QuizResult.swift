//
//  QuizResult.swift
//  QuizEngine
//
//  Created by Tifo Audi Alif Putra on 05/02/22.
//

import Foundation

struct QuizResult<Question: Hashable, Answer> {
    let answer: [Question: Answer]
    let score: Int
}
