//
//  File.swift
//  
//
//  Created by Kuo, Ray on 8/17/22.
//

import Vapor

public protocol CallProvider {
    func send(_ sms: OutgoingCall) async throws -> ClientResponse
}

extension Twilio: CallProvider {
    public func send(_ call: OutgoingCall) async throws -> ClientResponse {
        guard let configuration = self.configuration else {
            fatalError("Twilio not configured. Use app.twilio.configuration = ...")
        }
        let twilioURI = URI(string: "https://api.twilio.com/2010-04-01/Accounts/\(configuration.accountId)/Calls.json")
        return try await application.client.post(twilioURI, headers: configuration.headers, beforeSend: { req in
            try req.content.encode(call, as: .urlEncodedForm)
        })
    }
}
