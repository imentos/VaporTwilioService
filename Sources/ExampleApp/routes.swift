import Vapor
import Twilio

/// Register your application's routes here.
func routes(_ app: Application) throws {
    // Basic "It works" example
    //(831) 610-0806
    app.get { req -> EventLoopFuture<ClientResponse> in
//        let sms = OutgoingSMS(body: "Hey There", from: "+14054496618", to: "+16508478622")
//
//        return req.twilio.send(sms)
        
        let call = OutgoingCall(twiml: "<Response><Say>This is Ray</Say></Response>", from: "+14054496618", to: "+16508478622")
//        let call = OutgoingCall(url: "http://demo.twilio.com/docs/voice.xml", from: "+14054496618", to: "+16508478622")
        return req.twilio.send(call)
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


