//
//  RespondToExample.swift
//  FoundationModelCourse2
//
//  Created by DevTechie on 10/20/25.
//

import Foundation
import FoundationModels
import Playgrounds

/*
 
 Sends a prompt
 Returns a complete result
 Generates responses
 Manages conversation state
 Supports customization
 
 
 Use cases
 Summarization
 Entity Extraction
 Language Translation
 */

#Playground {
    let session = LanguageModelSession()
    let options = GenerationOptions(temperature: 1.0)
    var response = try await session.respond(to: "I have three cats: Leo, Cleo and Neo.", options: options)
    print(response.content)
    
    response = try await session.respond(to: "Which one is orange?", options: options)
    print(response.content)
}
