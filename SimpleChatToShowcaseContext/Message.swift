//
//  Message.swift
//  FoundationModelCourse2
//
//  Created by DevTechie on 10/20/25.
//

import Foundation

struct Message: Identifiable {
    let id: UUID = UUID()
    let text: String
    let isUser: Bool
}
