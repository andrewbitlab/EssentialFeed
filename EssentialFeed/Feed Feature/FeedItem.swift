//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Andrzej Kwiatkowski on 30/05/2023.
//

import Foundation

struct FeedItem {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
