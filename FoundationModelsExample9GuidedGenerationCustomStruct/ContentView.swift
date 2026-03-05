//
//  ContentView.swift
//  FoundationModelsExample9GuidedGenerationCustomStruct
//
//  Created by Quanpeng Yang on 3/5/26.
//

import SwiftUI
import FoundationModels

// Top-level struct for guided generation
@Generable(description: "An array of the names of the items, lowercase")
struct ItemNames: Codable {
    let names: [String]
}

struct ContentView: View {
    @State private var response = ""

    var body: some View {
        VStack {
            Button("Send") {
                let prompt = "Return only the seven standard colors of the rainbow."
                let instructions = """
                Return an array of items
                """
                
                let session = LanguageModelSession(instructions: instructions)
            
                if !session.isResponding {
                    Task {
                        do {
                            let answer = try await session.respond(
                                to: prompt,
                                generating: ItemNames.self,
                            )
                            response = answer.content.names.joined(separator: ", ")
                        } catch {
                            response = "Error accessing the model: \(error)"
                        }
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
            Text(response)
                .font(.system(size: 18))
                .padding()
            
            Spacer()
        }
        .padding()
    }
}
