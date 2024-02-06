//
//  EditCard.swift
//  Cardio
//
//  Created by Ricardo Herrera on 2/6/24.
//
import SwiftData
import SwiftUI

struct EditCard: View {
	@State var card: Card
	@Binding var showSheet: Bool
	var body: some View {
		VStack {
			TextField("Question", text: $card.question)
			TextField("Answer", text: $card.answer)
			Button("Save") {
				showSheet = false
			}

		}
	}
}
