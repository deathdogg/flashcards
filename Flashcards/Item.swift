//
//  Item.swift
//  Flashcards
//
//  Created by Ricardo Herrera on 1/28/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
