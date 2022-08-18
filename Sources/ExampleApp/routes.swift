import Vapor
import Twilio

/// Register your application's routes here.
func routes(_ app: Application) throws {
    app.get { req async throws -> ClientResponse in
        let call = OutgoingCall(twiml: "<Response><Say>This is Ray</Say></Response>", from: "+14054496618", to: "+16508478622")
        return try await req.twilio.send(call)
    }

    app.post("incoming") { req -> Response in
        let sms = try req.content.decode(IncomingSMS.self)
        let responseMessage = SMSResponse(
            Message(body: "Hello Friend!"),
            Message(body: "This is a second text.")
        )

        return req.twilio.respond(with: responseMessage)
    }
}


