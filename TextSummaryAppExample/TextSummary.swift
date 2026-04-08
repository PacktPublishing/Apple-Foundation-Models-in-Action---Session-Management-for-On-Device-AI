//
//  TextSummary.swift
//  FoundationModelCourse2
//
//  Created by DevTechie on 10/13/25.
//

import SwiftUI

struct TextSummary: View {
    
    @State private var viewModel = TextSummaryViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $viewModel.inputText)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                    .padding()
                
                Button("Generate Summary") {
                    Task {
                        await viewModel.summarize()
                    }
                }
                .disabled(viewModel.isResponding)
                .overlay {
                    if viewModel.isResponding {
                        ProgressView()
                    }
                }
                
                ScrollView {
                    Text(viewModel.outputText)
                }
            }
        }
    }
}

#Preview {
    TextSummary()
}
