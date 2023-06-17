//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Andrzej Kwiatkowski on 17/06/2023.
//

import XCTest

class URLSessionHTTPClient {
    let session: URLSession!
    
    init(session: URLSession) {
        self.session = session
    }
    
    func load(from url: URL) {
        session.dataTask(with: url) { _, _, _ in }
    }
}

final class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_createdDataTaskWithURL() {
        let url = URL(string: "https://any-url.com")!
        let session = URLSessionSpy()
        
        let sut = URLSessionHTTPClient(session: session)
        
        sut.load(from: url)
        
        XCTAssertEqual(session.receivedURLs, [url])
    }
    
    private class URLSessionSpy: URLSession {
        var receivedURLs = [URL]()
        
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            receivedURLs.append(url)
            
            return FakeURLSessionDataTask()
        }
    }
    
    private class FakeURLSessionDataTask: URLSessionDataTask {}

}
