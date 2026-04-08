//
//  TextSummaryViewModel.swift
//  FoundationModelCourse2
//
//  Created by DevTechie on 10/13/25.
//

import Foundation
import FoundationModels
import Observation

@Observable
final class TextSummaryViewModel {
    var inputText: String = ""
    var outputText: String = "Summary will go here..."
    var isResponding = false
    private var model = SystemLanguageModel.default
    
    init() {
        checkModelAvailability()
    }
    
    func checkModelAvailability() {
        switch model.availability {
        case .available:
            outputText = "Model is available and summary will appear here."
        case .unavailable(.deviceNotEligible):
            outputText = "Model is not available. Device is not elligible for Apple Intelligence."
        case .unavailable(.appleIntelligenceNotEnabled):
            outputText = "Model is available but Apple Intelligence is not enabled."
        case .unavailable(.modelNotReady):
            outputText = "Model is not ready yet. Please try again later."
        case .unavailable:
            outputText = "Model is not available due to unknown reasons."
        }
    }
    
    func summarize() async {
        let instructions = "You are a summary agent helping create 100 words summary for given text."
        let session = LanguageModelSession(instructions: instructions)
        do {
            isResponding = true
            let response = try await session.respond(to: inputText)
            outputText = response.content
            isResponding = false
        }
        catch {
            isResponding = false
            outputText = "Error: \(error.localizedDescription)"
        }
    }
}
