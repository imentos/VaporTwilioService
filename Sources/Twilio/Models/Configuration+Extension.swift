//
//  File.swift
//  
//
//  Created by Kuo, Ray on 8/18/22.
//

import Vapor

extension TwilioConfiguration {
    var headers: HTTPHeaders {
        get throws {
            let authKeyEncoded = try self.encode(accountId: accountId, accountSecret: accountSecret)
            var headers = HTTPHeaders()
            headers.add(name: .authorization, value: "Basic \(authKeyEncoded)")
            return headers
        }
    }
    
    func encode(accountId: String, accountSecret: String) throws -> String {
        guard let apiKeyData = "\(accountId):\(accountSecret)".data(using: .utf8) else {
            throw TwilioError.encodingProblem
        }
        let authKey = apiKeyData.base64EncodedData()
        guard let authKeyEncoded = String.init(data: authKey, encoding: .utf8) else {
            throw TwilioError.encodingProblem
        }
        return authKeyEncoded
    }
}
