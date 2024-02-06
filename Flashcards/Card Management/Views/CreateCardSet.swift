//
//  CreateCardSet.swift
//  Flashcards
//
//  Created by Ricardo Herrera on 1/28/24.
//
import Foundation
import SwiftUI
import SwiftData
struct CreateCardSet: View {
	@Environment(\.modelContext) private var moc
	@State var newSet = CardSet(cards: [], title: "")
	var body: some View {
		TextField("enter Title", text: $newSet.title)
		Button("Save") {
			moc.insert(newSet)
		}
	}
}
