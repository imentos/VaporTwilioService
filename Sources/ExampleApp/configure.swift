import Vapor
import Twilio

/// Called before your application initializes.
public func configure(_ app: Application) throws {
//    app.twilio.configuration = .environment
    app.twilio.configuration = .init(accountId: "AC37be6f46dbdaca1fbf7d97edbc105284", accountSecret: "d0e12e54c0870932b64cf3a564677c6f")
    try routes(app)
}
