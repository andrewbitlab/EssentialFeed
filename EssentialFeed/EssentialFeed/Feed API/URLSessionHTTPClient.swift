//
//  URLSessionHTTPClient.swift
//  EssentialFeed
//
//  Created by Andrzej Kwiatkowski on 21/06/2023.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    public func get(from url: URL, completion: @escaping (HTTPClienResult) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else if let error {
                completion(.failure(error))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
}
