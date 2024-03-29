//
//  Item.swift
//  Flashcards
//
//  Created by Ricardo Herrera on 1/28/24.
//

import Foundation
import SwiftData

@Model
final class Card {
	var question: String
	var answer: String
	init(question: String, answer: String) {
		self.question = question
		self.answer = answer
	}
}
