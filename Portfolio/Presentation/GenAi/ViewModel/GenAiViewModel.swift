//
//  GenAiViewModel.swift
//  Portfolio
//
//  Created by joshmac on 9/2/24.
//

import Foundation

@MainActor class GenAiViewModel: ObservableObject {
    @Published var prompt: GenAiPromptModel?
    @Published var response: GenAiResponseEntryModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func getResponse(prompt: String) async throws {
        isLoading = true

        let promptModel = GenAiPromptModel(prompt: prompt)
        let result = try await GenAiGetUseCaseImplementation.execute(promptModel: promptModel)
        
        switch result {
        case .success(let response):
            self.response = response
        case .failure(let error):
            self.response = nil
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
