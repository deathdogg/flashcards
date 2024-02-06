//
//  SetViewer.swift
//  Flashcards
//
//  Created by Ricardo Herrera on 1/28/24.
//

import SwiftData
import SwiftUI
struct SetViewer: View {
	@Binding var path: NavigationPath
	@State private var showAddCard = false
	@Environment(\.modelContext) private var moc
	@State var setToView: CardSet
	@State private var showEditCard = false
	var body: some View {
		VStack(alignment: .center) {
			List {
				ForEach(Array(setToView.cards.enumerated()), id: \.offset) {
					c in
					Text(c.1.question)
						.font(.title)
						.sheet(isPresented: $showEditCard) {
							EditCard(card: c.1, showSheet: $showEditCard)
						}
						.accessibilityAction(named: "Edit") {
							showEditCard = true
						}
						.accessibilityAction(named: "Delete") {
							setToView.cards.remove(at: c.offset)
						}
				}
			}
			.listRowSpacing(10.0)
		}
		.sheet(isPresented: $showAddCard) {
			AddACard(showSheet: $showAddCard, set: $setToView)
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button("Add") {
					showAddCard.toggle()
				}
			}
			ToolbarItem(placement: .bottomBar) {
				NavigationLink("Review") {
					FlashcardReviewMode(set: setToView, path: $path)
				}
			}
		}
		.navigationTitle(setToView.title)
	}
}
