//
//  QuizResult.swift
//  QuizEngine
//
//  Created by Tifo Audi Alif Putra on 05/02/22.
//

import Foundation

public struct QuizResult<Question: Hashable, Answer> {
    public let answer: [Question: Answer]
    public let score: Int
}
