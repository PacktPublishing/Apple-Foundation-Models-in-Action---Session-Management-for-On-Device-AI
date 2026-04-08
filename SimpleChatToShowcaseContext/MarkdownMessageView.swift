//
//  MarkdownMessageView.swift
//  FoundationModelCourse2
//
//  Created by DevTechie on 10/21/25.
//

import SwiftUI

struct MarkdownMessageView: View {
    let message: Message
    @State private var attrubutedText: AttributedString?
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            if message.isUser {
                Spacer(minLength: 50)
            }
            
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                if message.isUser {
                    Text(message.text)
                        .padding(12)
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 16, style: .continuous))
                } else {
                    Group {
                        if let attrubutedText = attrubutedText {
                            Text(attrubutedText)
                        } else {
                            Text(message.text)
                        }
                    }
                    .textSelection(.enabled)
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .foregroundStyle(.primary)
                    .clipShape(.rect(cornerRadius: 16, style: .continuous))
                    .task {
                        do {
                            attrubutedText = try AttributedString(styledMarkdown: message.text)
                                
                        } catch {
                            attrubutedText = AttributedString(message.text)
                        }
                    }
                }
            }
            if !message.isUser {
                Spacer(minLength: 50)
            }
        }
    }
}

#Preview {
    MarkdownMessageView(message: Message(text: "# Hello there!", isUser: false))
}
