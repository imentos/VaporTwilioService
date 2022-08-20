import Vapor
import Twilio

/// Register your application's routes here.
func routes(_ app: Application) throws {
    app.get { req async throws -> ClientResponse in
        let call = OutgoingCall(
            twiml: "<Response><Say>This is Ray</Say></Response>",
            from: "+14054496618",
            to: "+16508478622",
            statusCallback: "https://1c2d-169-145-42-40.ngrok.io/status")
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
        
    app.post("status") { req async throws -> Response in
        let status = try req.content.decode(StatusCallback.self)
        print(status.CallStatus)
        return Response(status: .ok)
    }
}

struct StatusCallback: Content {
    var CallStatus: String
}


