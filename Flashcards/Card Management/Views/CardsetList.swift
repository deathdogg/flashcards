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
	@State var showEditSet = false
	@Binding var path: NavigationPath
	@Query private var sets: [CardSet]
	@State var title = ""
	var body: some View {
		VStack(alignment: .center) {
			List(sets) {
				set in
				NavigationLink(value: set) {
					Text(set.title)
						.font(.title)
				}
					.sheet(isPresented: $showEditSet) {
						EditCardSet(set: set, showSheet: $showEditSet)
					}
					.accessibilityAction(named: "delete") {
						moc.delete(set)
					}
					.accessibilityAction(named: "Rename") {
						showEditSet = true
					}
			}
		}

		.navigationDestination(for: CardSet.self) {
			s in
			SetViewer(path: $path, setToView: s)
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
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
		.navigationTitle("Cardio")
	}

}

