//
//  File.swift
//  
//
//  Created by Kuo, Ray on 8/17/22.
//

import Vapor

public protocol CallProvider {
    func send(_ sms: OutgoingCall) -> EventLoopFuture<ClientResponse>
}

extension Twilio: CallProvider {
    public func send(_ call: OutgoingCall) -> EventLoopFuture<ClientResponse> {
        guard let configuration = self.configuration else {
            fatalError("Twilio not configured. Use app.twilio.configuration = ...")
        }
        
        return application.eventLoopGroup.future().flatMapThrowing { _ -> HTTPHeaders in
            let authKeyEncoded = try self.encode(accountId: configuration.accountId, accountSecret: configuration.accountSecret)
            var headers = HTTPHeaders()
            headers.add(name: .authorization, value: "Basic \(authKeyEncoded)")
            return headers
        }.flatMap { headers in
            let twilioURI = URI(string: "https://api.twilio.com/2010-04-01/Accounts/\(configuration.accountId)/Calls.json")
            return self.application.client.post(twilioURI, headers: headers) {
                try $0.content.encode(call, as: .urlEncodedForm)
            }
        }
    }
}
