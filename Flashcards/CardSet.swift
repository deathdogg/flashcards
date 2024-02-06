//
//  CardSet.swift
//  Flashcards
//
//  Created by Ricardo Herrera on 1/28/24.
//

import Foundation
import SwiftData
@Model
final class CardSet {
	var title: String
	@Relationship(deleteRule: .cascade, inverse: \Card.set)
	var cards: [Card]
	init(cards: [Card], title: String) {
		self.title = title

		self.cards = cards
	}
}
