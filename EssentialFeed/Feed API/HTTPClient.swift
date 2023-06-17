//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Andrzej Kwiatkowski on 14/06/2023.
//

import Foundation

public enum HTTPClienResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClienResult) -> Void)
}