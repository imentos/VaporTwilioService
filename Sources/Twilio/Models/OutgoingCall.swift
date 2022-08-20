//
//  File.swift
//  
//
//  Created by Kuo, Ray on 8/17/22.
//

import Vapor

public struct OutgoingCall: Content {
    let twiml: String
    let from: String
    let to: String
    let statusCallback: String

    public init(twiml: String, from: String, to: String, statusCallback: String) {
        self.twiml = twiml
        self.from = from
        self.to = to
        self.statusCallback = statusCallback
    }

    private enum CodingKeys : String, CodingKey {
        case twiml = "Twiml", from = "From", to = "To", statusCallback = "StatusCallback"
    }
}
