//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Andrzej Kwiatkowski on 17/06/2023.
//

import EssentialFeed
import XCTest

class URLSessionHTTPClient {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClienResult) -> Void) {
        session.dataTask(with: url) { _, _, error in
            if let error {
                completion(.failure(error))
            }
        }.resume()
    }
}

final class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_failsOnrequestError() {
        URLProtocol.registerClass(URLProtocolStub.self)
        
        let url = URL(string: "https://any-url.com")!
        let error = NSError(domain: "Error", code: 1)
        URLProtocolStub.stub(url: url, error: error)
        
        let sut = URLSessionHTTPClient()
        
        let exp = expectation(description: "Wait for callback")
        sut.get(from: url) { result in
            
            switch result {
            case .failure(let receivedError as NSError):
                XCTAssertEqual(receivedError.domain, error.domain)
                XCTAssertEqual(receivedError.code, error.code)
            default:
                XCTFail("Expected failure with error \(error), got \(result) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        
        URLProtocol.unregisterClass(URLProtocolStub.self)
    }
    
    private class URLProtocolStub: URLProtocol {
        static private var stubs = [URL: Stub]()
        
        private struct Stub {
            var error: Error?
        }
        
        static func stub(url: URL, error: Error? = nil) {
            stubs[url] = Stub(error: error)
        }
        
        override class func canInit(with request: URLRequest) -> Bool {
            guard let url = request.url else { return false }

            return URLProtocolStub.stubs[url] != nil
        }
            
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
            
        override func startLoading() {
            guard let url = request.url, let stub = URLProtocolStub.stubs[url] else { return }

            if let error = stub.error {
                client?.urlProtocol(self, didFailWithError: error)
            }

            client?.urlProtocolDidFinishLoading(self)
        }
            
        override func stopLoading() {}
    }
}
