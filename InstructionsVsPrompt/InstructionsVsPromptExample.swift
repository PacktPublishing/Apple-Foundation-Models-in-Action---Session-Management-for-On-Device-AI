//
//  InstructionsVsPromptExample.swift
//  FoundationModelCourse2
//
//  Created by DevTechie on 10/20/25.
//

import Foundation
import FoundationModels
import Playgrounds

#Playground {
    let session = LanguageModelSession(instructions: "You are a friendly Spanish teacher, provide translations, definition, and example sentence in Spanish and English for given prompt")
    
    var response = try await session.respond(to: "see you tomorrow")
    print(response.content)
    
    response = try await session.respond(to: "How are you?")
    print(response.content)
    
}

/*
 #Playground {
 let session = LanguageModelSession(instructions: "You are a friendly Spanish teacher, give translations, simple definition and one example sentence in Spanish and English")
 let response = try await session.respond(to: "see you tomorrow")
 print(response.content)
 
 let session1 = LanguageModelSession()
 let response1 = try await session1.respond(to: "translate `see you tomorrow` in Spanish and give me defition and example sentence")
 print(response1.content)
 
 }
 */
