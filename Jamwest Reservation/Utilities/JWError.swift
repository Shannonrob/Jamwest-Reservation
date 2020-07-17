//
//  JWError.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 7/16/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

enum JWError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case malfunction = "Something went wrong"
}
