//
//  FlashcardReviewMode.swift
//  Flashcards
//
//  Created by Ricardo Herrera on 2/5/24.
//

import SwiftUI
import SwiftData
struct FlashcardReviewMode: View {
	@FocusState var reviewFocused
	@State var set: CardSet
	@State var workingSet: [Card]?
	@State var currentCard = 0
	@Binding var path: NavigationPath
	@State private var showAnswer = false
	var drag: some Gesture {
		DragGesture(minimumDistance: 50.0)

			.onChanged {
				g in
				if g.translation.width > 0 {
					nextCard()
				} else if g.translation.width < 0 {
					previousCard()
				}
			}
	}
	var body: some View {
		VStack {
			if set.cards.count > 0 {
				if !showAnswer {
					Text("question: \(workingSet?[currentCard].question ?? set.cards[currentCard].question)")
						.onTapGesture {
							showAnswer = true
						}
				} else {
					Text("Answer: \(workingSet?[currentCard].answer ?? set.cards[currentCard].answer)")
						.onTapGesture {
							showAnswer = false
						}
				}
			}
		}
		.focusable(true)
		.focused($reviewFocused)
		.onAppear {
			reviewFocused = true
		}
		.gesture(drag)
		.onKeyPress(.leftArrow) {
			previousCard()
				return .handled
		}
		.onKeyPress(.rightArrow) {
			nextCard()
				return .handled
		}
		.toolbar {
			ToolbarItem(placement: .bottomBar) {
				Button("Previous") {
					previousCard()
				}
			}
			ToolbarItem(placement: .bottomBar) {
				Button("Shuffle") {
					if set.cards.count > 0 {
						workingSet = set.cards.shuffled()
					}
				}
//				.disabled(true)
			}
			ToolbarItem(placement: .bottomBar) {
				Button("Next"){
					nextCard()
				}
			}
		}
		.navigationTitle("Card Review")
	}
	func nextCard() {
		if set.cards.count > 0 && currentCard < set.cards.count-1 {
			currentCard += 1
		}
	}
	func previousCard() {
		if set.cards.count > 0 && currentCard > 0 {
			currentCard -= 1
		}
	}
}

