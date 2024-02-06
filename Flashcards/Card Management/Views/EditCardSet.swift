//
//  EditCardSet.swift
//  Cardio
//
//  Created by Ricardo Herrera on 2/6/24.
//

import SwiftUI
import SwiftData

struct EditCardSet: View {
	@State var set: CardSet
	@Binding var showSheet: Bool
	var body: some View {
		VStack {
			TextField("", text: $set.title)
			Button("Save") {
				showSheet = false
			}
		}
	}
}
