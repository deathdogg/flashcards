//
//  FlashcardReviewMode.swift
//  Flashcards
//
//  Created by Ricardo Herrera on 2/5/24.
//

import SwiftUI

struct FlashcardReviewMode: View {
	@State var set: CardSet
	@State var currentCard = 0
	@Binding var path: NavigationPath
	@State private var showAnswer = false
	var body: some View {
		VStack {
			if set.cards.count > 0 {
				if !showAnswer {
					Text("question: \(set.cards[currentCard].question)")
						.onTapGesture {
							showAnswer = true
						}
				} else {
					Text("Answer: \(set.cards[currentCard].answer)")
						.onTapGesture {
							showAnswer = false
						}
				}
			}
		}
		.toolbar {
			ToolbarItem(placement: .bottomBar) {
				Button("Previous") {
					if set.cards.count > 0 && currentCard > 0 {
						currentCard -= 1
					}
				}
			}
			ToolbarItem(placement: .bottomBar) {
				Button("Shuffle") {
					if set.cards.count > 0 {
						set.cards.shuffle()
					}
				}
			}
			ToolbarItem(placement: .bottomBar) {
				Button("Next"){
					if set.cards.count > 0 && currentCard < set.cards.count-1 {
						currentCard += 1
					}
				}
			}
		}
	}
}

