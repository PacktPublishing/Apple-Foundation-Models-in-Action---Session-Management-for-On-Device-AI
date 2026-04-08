//
//  SessionExplored.swift
//  FoundationModelCourse2
//
//  Created by DevTechie on 10/14/25.
//

import Foundation
import FoundationModels
import Playgrounds

/*
 
// MARK: - Single turn interaction
 
 #Playground {
 let session = LanguageModelSession()
 
 var response = try await session.respond(to: "translate hello in spanish")
 print(response.content)
 // 4096
 let session1 = LanguageModelSession()
 var response1 = try await session1.respond(to: "complete this for me: once upon a time there was")
 print(response1.content)
 }
 
 */

///*
 
// MARK: - Single turn interaction
 
 #Playground {
 var session = LanguageModelSession()
 
 var response = try await session.respond(to: "translate hello in spanish")
 print(response.content)
 // 4096
 session = LanguageModelSession()
 response = try await session.respond(to: "complete this for me: once upon a time there was")
 print(response.content)
 }
 
 //*/

// MARK: - Multi-turn interaction

/*
#Playground {
    let session = LanguageModelSession()
    var response = try await session.respond(to: "translate hello in spanish")
    print(response.content)
    
    response = try await session.respond(to: "how about: good night?")
    print(response.content)
    
    response = try await session.respond(to: "what about: how much is this? ")
    print(response.content)
    
}
*/
