//
//  ChatViewModel.swift
//  FoundationModelCourse2
//
//  Created by DevTechie on 10/20/25.
//

import Foundation
import FoundationModels
import Observation

@MainActor
@Observable
final class ChatViewModel {
    var messages: [Message] = []
    var inputText: String = ""
    var isResponding: Bool = false
    
    private var session: LanguageModelSession
    
    init() {
        let instructions = "You are a helpful, friendly assistant, respond concisely and naturally."
        session = LanguageModelSession(instructions: instructions)
    }
    
    func sendMessage() async {
        guard !inputText.isEmpty else { return }
        
        let userMessage = Message(text: inputText, isUser: true)
        messages.append(userMessage)
        
        let prompt = inputText
        inputText = ""
        isResponding = true
        
        do {
            let response = try await session.respond(to: prompt)
            let botMessage = Message(text: response.content, isUser: false)
            messages.append(botMessage)
        } catch {
            let errorMessage = Message(text: "I'm sorry, I din't understand that. Error: \(error.localizedDescription)", isUser: false)
            messages.append(errorMessage)
        }
        
        isResponding = false
    }
}
