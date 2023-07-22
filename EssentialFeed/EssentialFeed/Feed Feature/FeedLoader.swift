//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Andrzej Kwiatkowski on 30/05/2023.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
