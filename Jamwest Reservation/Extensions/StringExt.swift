//
//  StringExt.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 8/13/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
