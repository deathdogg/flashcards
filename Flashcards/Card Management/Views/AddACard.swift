//
//  AddACard.swift
//  Flashcards
//
//  Created by Ricardo Herrera on 2/5/24.
//

import SwiftUI
import SwiftData
struct AddACard: View {
	@Binding var showSheet: Bool
	@Environment(\.modelContext) private var moc
	@Binding var set: CardSet
	@State private var question = ""
	@State private var answer = ""
	var body: some View {
		VStack {
			TextField("Question", text: $question)
			TextField("Answer", text: $answer)
			Button("Save") {
				let newCard = Card(question: question, answer: answer, set: set)
				set.cards.append(newCard)
				do {
					try moc.save()
					showSheet = false
				} catch {
					print(error)
				}
			}
		}

	}
}
/*
#Preview {
	@State var cards = CardSet(cards: [], title: "test")
	@State var show = true
	AddACard(showSheet: $show, set: $cards)
}

*/
