//
//  File.swift
//  
//
//  Created by Kuo, Ray on 8/23/22.
//

import Vapor

public protocol SMSProvider {
    func send(_ sms: OutgoingSMS) async throws -> ClientResponse
}

extension Twilio: SMSProvider {
    public func send(_ call: OutgoingSMS) async throws -> ClientResponse {
        guard let configuration = self.configuration else {
            fatalError("Twilio not configured. Use app.twilio.configuration = ...")
        }
        let twilioURI = URI(string: "https://api.twilio.com/2010-04-01/Accounts/\(configuration.accountId)/Messages.json")
        return try await application.client.post(twilioURI, headers: configuration.headers, beforeSend: { req in
            try req.content.encode(call, as: .urlEncodedForm)
        })
    }
}
