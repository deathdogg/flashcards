//
//  FlashcardReviewMode.swift
//  Flashcards
//
//  Created by Ricardo Herrera on 2/5/24.
//
import AVFoundation
import SwiftUI
import SwiftData
struct FlashcardReviewMode: View {
	@State private var player: AVAudioPlayer?
	@FocusState var reviewFocused
	@State var set: CardSet
	@State var workingSet: [Card]?
	@State var currentCard = 0
	@Binding var path: NavigationPath
	@State private var showAnswer = false
	@AccessibilityFocusState private var focusedOnQuestion
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
				Group {
					if !showAnswer {
						Text("question: \(workingSet?[currentCard].question ?? set.cards[currentCard].question)")
							.accessibilityAddTraits(.isButton)
							.onTapGesture {
								showAnswer = true
							}
					} else {
						Text("Answer: \(workingSet?[currentCard].answer ?? set.cards[currentCard].answer)")
						//TODO: Work on allowing multi-line answers to be viewable line by line with simple swiping actions with voiceover
							.accessibilityTextContentType(.plain)
							.accessibilityAddTraits(.isButton)
							.onTapGesture {
								showAnswer = false
							}
					}
				}

				.accessibilityFocused($focusedOnQuestion)
				.onAppear {
					focusedOnQuestion = true
				}
			}
		}
		.focusable(true)
		.focused($reviewFocused)
		.onAppear {
			reviewFocused = true
		}
		.gesture(drag)
		.accessibilityScrollAction {
			edge in
			switch edge {
			case .trailing:
				previousCard()
			case .leading:
				nextCard()
			default:
				return
			}

		}
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
			UIAccessibility.post(notification: .pageScrolled, argument: "Next card")
			focusedOnQuestion = true
			showAnswer = false
			UIAccessibility.post(notification: .layoutChanged, argument: nil)
			if player == nil || player!.isPlaying {
				let url: URL! = Bundle.main.url(forResource: "take_card", withExtension: "mp3")
				let player = try! AVAudioPlayer(contentsOf: url)
				self.player = player
				self.player?.play()
			} else {
				player?.play()
			}
		}
	}
	func previousCard() {
		if set.cards.count > 0 && currentCard > 0 {
			currentCard -= 1
			UIAccessibility.post(notification: .pageScrolled, argument: "Previous Card")
			focusedOnQuestion = true
			showAnswer = false
			UIAccessibility.post(notification: .layoutChanged, argument: nil)
			if player == nil || player!.isPlaying {
				let url: URL! = Bundle.main.url(forResource: "take_card", withExtension: "mp3")
				let player = try! AVAudioPlayer(contentsOf: url)
				self.player = player
				self.player?.play()
			} else {
				self.player?.play()
			}
		}
	}
}

