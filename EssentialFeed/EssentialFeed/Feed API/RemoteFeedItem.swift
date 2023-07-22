//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Andrzej Kwiatkowski on 06/07/2023.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
