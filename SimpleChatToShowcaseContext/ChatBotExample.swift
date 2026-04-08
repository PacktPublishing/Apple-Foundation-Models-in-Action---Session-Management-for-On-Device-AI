//
//  ChatBotExample.swift
//  FoundationModelCourse2
//
//  Created by DevTechie on 10/21/25.
//

import SwiftUI

struct ChatBotExample: View {
    @State private var viewModel = ChatViewModel()
    @FocusState private var isInputFocused: Bool
    
    @ViewBuilder
    private var chatMessageView: some View {
        ForEach(viewModel.messages) { message in
            
            MarkdownMessageView(message: message)
                .id(message.id)
            
//            HStack {
//                if message.isUser {
//                    Spacer()
//                }
//                
//                Text(message.text)
//                    .padding(12)
//                    .background(message.isUser ? Color.blue.opacity(0.8) : Color.gray.opacity(0.2))
//                    .foregroundStyle(message.isUser ? .white : .primary)
//                    .clipShape(.rect(cornerRadius: 12))
//                
//                if !message.isUser {
//                    Spacer()
//                }
//            }
        }
    }
    
    @ViewBuilder
    private var messageInputView: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            if viewModel.isResponding {
                HStack(spacing: 6) {
                    ProgressView()
                        .scaleEffect(0.7)
                    
                    Text("DevTechie is thinking...")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
            }
            
            HStack(alignment: .bottom, spacing: 12) {
                TextField("Type a message", text: $viewModel.inputText, axis: .vertical)
                    .textFieldStyle(.plain)
                    .padding(12)
                    .lineLimit(1...6)
                    .focused($isInputFocused)
                    .disabled(viewModel.isResponding)
                    .onSubmit {
                        if !viewModel.inputText.isEmpty && !viewModel.isResponding {
                            Task {
                                await viewModel.sendMessage()
                            }
                        }
                    }
                
                Button(action: {
                    Task {
                        await viewModel.sendMessage()
                        isInputFocused = true
                    }
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(viewModel.inputText.isEmpty || viewModel.isResponding ? .gray : .blue)
                }
                .disabled(viewModel.isResponding || viewModel.inputText.isEmpty)
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding()
            .glassEffect(.clear)
        }
        
//        VStack(alignment: .leading, spacing: 0) {
//            if viewModel.isResponding {
//                Text("DevTechie is thinking...")
//                    .font(.caption2)
//                    .foregroundStyle(.secondary)
//            }
//            
//            HStack {
//                TextField("Type a message", text: $viewModel.inputText)
//                    .textFieldStyle(.roundedBorder)
//                    .padding()
//                    .disabled(viewModel.isResponding)
//                
//                Button(action: {
//                    Task {
//                        await viewModel.sendMessage()
//                    }
//                }) {
//                    Image(systemName: "paperplane.circle.fill")
//                        .font(.title)
//                }
//                .disabled(viewModel.isResponding || viewModel.inputText.isEmpty)
//            }
//            .padding([.horizontal, .bottom])
//        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        chatMessageView
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages.count) { _, _ in
                    if let lastId = viewModel.messages.last?.id {
                        withAnimation {
                            proxy.scrollTo(lastId, anchor: .bottom)
                        }
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                messageInputView
            }
            .navigationTitle("DevTechie's Travel Bot")
        }
    }
}

#Preview {
    ChatBotExample()
}
