//
//  CardsetList.swift
//  Flashcards
//
//  Created by Ricardo Herrera on 1/28/24.
//
import Foundation
import SwiftData
import SwiftUI

struct CardsetList: View {
	@Environment(\.modelContext) private var moc
	@State var showAddSet = false
	@Binding var path: NavigationPath
	@Query private var sets: [CardSet]
	@State var title = ""
	var body: some View {
		VStack {
			List(sets) {
				set in
				NavigationLink(set.title, value: set)
					.accessibilityAction(named: "delete") {
						moc.delete(set)
					}

			}
		}
		.navigationDestination(for: CardSet.self) {
			s in
			SetViewer(path: $path, setToView: s)
		}
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				Button("Add Card Set") {
					showAddSet.toggle()
				}
			}
		}
		.sheet(isPresented: $showAddSet) {
			TextField("Title", text: $title)
			Button("Save") {
				let newSet = CardSet(cards: [], title: title)
				moc.insert(newSet)
				do {
					try moc.save()
					showAddSet = false
				} catch {
					print(error)
				}
			}
		}
	}


}

