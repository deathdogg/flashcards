//
//  FlashcardsApp.swift
//  Flashcards
//
//  Created by Ricardo Herrera on 1/28/24.
//

import SwiftUI
import SwiftData

@main
struct FlashcardsApp: App {
	var sharedModelContainer: ModelContainer = {
		let schema = Schema([
			Card.self,
			CardSet.self,
		])
		let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

		do {
			return try ModelContainer(for: schema, configurations: [modelConfiguration])
		} catch {
			fatalError("Could not create ModelContainer: \(error)")
		}
	}()

	var body: some Scene {
		WindowGroup {
			ContentView()
		}
		.modelContainer(sharedModelContainer)
	}
}
