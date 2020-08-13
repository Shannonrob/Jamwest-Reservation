//
//  JWError.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 7/16/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

enum JWError: String, Error {
    case unableToCompleteRequest = "Unable to complete your request. Please check your internet connection"
    case unableToComplete = "Unable to complete your request."
    case malfunction = "Something went wrong"
    case reservationLimit = "All waivers for this tour has already been completed. Please check with staff"
    case signatureRequired = "Your signature is required to complete the Waiver & Release of Liability"
    case noUser = "There is no user record corresponding to this identifier. The user may have been deleted."
    case invalidPassword = "The password is invalid or the user does not have a password."
    case invalidEmailMessage = "Invalid email, \nGive it another try."
    case invalidPasswordMessage = "Password is invalid, \nGive it another try."
}
