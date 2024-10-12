//
//  DiscogsUsernameUseCase.swift
//  Portfolio
//
//  Created by joshmac on 9/2/24.
//

protocol DiscogsUsernameUseCase {
    static func execute() async throws -> Result<Bool, Error>
}

struct DiscogsUsernameUseCaseImplementation: DiscogsUsernameUseCase {
    static func execute() async throws -> Result<Bool, Error> {
        do {
            let authToken = try await DiscogsDataSource.retrieveAccessToken()
            let authTokenSecret = try await DiscogsDataSource.retrieveAccessTokenSecret()
            let response = try await DiscogsRepository.username(forAuthToken: authToken, andAuthTokenSecret: authTokenSecret)
            try await DiscogsDataSource.saveUsername(response)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
}