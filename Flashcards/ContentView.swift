//
//  ContentView.swift
//  Flashcards
//
//  Created by Ricardo Herrera on 1/28/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	@State private var path = NavigationPath()
	@Environment(\.modelContext) private var modelContext
	var body: some View {
		NavigationStack {
			CardsetList(path: $path)
		}
	}
}
