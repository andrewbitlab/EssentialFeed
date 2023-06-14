//
//  FeedItemMapper.swift
//  EssentialFeed
//
//  Created by Andrzej Kwiatkowski on 14/06/2023.
//

import Foundation

internal class FeedItemMapper {
    private struct Root: Decodable {
        let items: [Item]
        
        var feedItems: [FeedItem] {
            return items.map { $0.feedItem }
        }
    }

    private struct Item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let image: URL
            
        var feedItem: FeedItem {
            return FeedItem(
                id: id,
                description: description,
                location: location,
                imageURL: image)
        }
    }
    
    private static var OK_200: Int { 200 }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
        guard let items = try? JSONDecoder().decode(Root.self, from: data).feedItems,  response.statusCode == OK_200 else {
            return .failure(.invalidData)
        }
        return .success(items)
    }
}
