//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Andrzej Kwiatkowski on 08/07/2023.
//

import EssentialFeed
import XCTest
    
func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}
    
func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}
