//
//  RMService.swift
//  RickAndMorty
//
//  Created by Caner Karabulut on 12.12.2023.
//

import Foundation

//MARK: - Primary API Service to get Rick and Morty data
class RMService {
    //MARK: - Shared singleton instance
    static let shared = RMService()
    //MARK: - Privatized Constructer
    private init() {}
    
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    //MARK: - Send Rick and Morty API Call
    /// - Parameters:
    ///     - request: Request instance
    ///     - type: The type of object expect to get back
    ///     - completion: Callback with data or error
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(RMServiceError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    //MARK: - Private request func
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
