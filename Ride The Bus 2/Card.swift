//
//  Card.swift
//  Ride The Bus 2
//
//  Created by Ricky Kyte on 3/27/24.
//

import Foundation

struct Card: Identifiable {
    let id = UUID()
    let suit: String
    let rank: String
    var numericValue: Int {
        switch rank {
        case "jack": return 11
        case "queen": return 12
        case "king": return 13
        case "ace": return 14
        default:
            if let value = Int(rank) {
                return value
            } else {
                return 0
            }
        }
    }
}
