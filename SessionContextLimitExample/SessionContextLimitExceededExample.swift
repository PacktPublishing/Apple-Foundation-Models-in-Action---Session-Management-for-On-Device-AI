//
//  SessionContextLimitExceededExample.swift
//  FoundationModelCourse2
//
//  Created by DevTechie on 10/17/25.
//

import FoundationModels
import SwiftUI

struct SessionContextLimitExceededExample: View {
    @State private var responseTxt: String = ""
    @State private var session = LanguageModelSession(instructions: "You are a helpful assistant.")
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    Text(responseTxt)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Send Message") {
                        Task {
                            try? await sendMessage()
                        }
                    }
                }
            }
            .navigationTitle("Chat with DevTechie's AI")
        }
    }
    
    func sendMessage() async throws {
        let largePrompt = String(repeating: "word ", count: 1000)
        do {
            let response = try await session.respond(to: largePrompt)
            responseTxt = response.content
            print(session.transcript)
        }
        catch LanguageModelSession.GenerationError.exceededContextWindowSize {
            print(session.transcript)
            responseTxt = "Exceeded context window size!"
            session = newSession(previousSession: session)
            responseTxt = "New session is ready, try again!"
        }
        catch {
            print(session.transcript)
            print(error.localizedDescription)
        }
    }
    
    func newSession(previousSession: LanguageModelSession) -> LanguageModelSession {
        let allEntries = previousSession.transcript.enumerated().map { $1 }
        var condensedEntries: [Transcript.Entry] = []
        if let firstEntry = allEntries.first {
            condensedEntries.append(firstEntry) // instructions
            
            if allEntries.count > 1, let lastEntry = allEntries.last {
                condensedEntries.append(lastEntry) // prompt or response
            }
        }
        let condensedTranscript = Transcript(entries: condensedEntries)
        return LanguageModelSession(transcript: condensedTranscript)
    }
}

/*
 
 let summaryPrompt = "Summarize this conversation briefly for context:"
 let summaryInput = session.transcript.description
 let summary = try await summarizerSession.respond(to: summaryPrompt + summaryInput)

 let condensedSession = LanguageModelSession(instructions: "You are continuing a conversation. Here's what happened before:\n\(summary.content)")
 
 */

#Preview {
    SessionContextLimitExceededExample()
}
