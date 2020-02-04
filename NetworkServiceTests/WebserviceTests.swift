//
//  WebserviceTests.swift
//  NetworkServiceTests
//
//  Created by Markus Faßbender on 04.02.20.
//

import XCTest
import OHHTTPStubs

@testable import NetworkService

class WebserviceTests: XCTestCase {

    enum TestError: Swift.Error {
        case fail
    }
    
    func testLoadResourceWithDataError() {
        let funcName = "testLoadResourceWithOtherError"
        let resource = Resource(url: URL(string: "https://apple.com/\(funcName)")!, parse: { $0 })
        let expectation = XCTestExpectation(description: funcName)
        
        stub(condition: isPath("/\(funcName)")) { _ in
            OHHTTPStubsResponse(error: Webservice.Error.data)
        }
        
        Webservice.shared.load(resource: resource) {
            do {
                _ = try $0.get()
                XCTFail("should throw error")
            } catch Webservice.Error.data {
                expectation.fulfill()
            } catch {
                XCTFail("error should be Webservice.Error.data")
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLoadResourceWithOtherError() {
        let funcName = "testLoadResourceWithOtherError"
        let resource = Resource(url: URL(string: "https://apple.com/\(funcName)")!, parse: { $0 })
        let expectation = XCTestExpectation(description: funcName)
        
        stub(condition: isPath("/\(funcName)")) { _ in
            OHHTTPStubsResponse(error: TestError.fail)
        }
        
        Webservice.shared.load(resource: resource) {
            do {
                _ = try $0.get()
                XCTFail("should throw error")
            } catch Webservice.Error.other(TestError.fail) {
                expectation.fulfill()
            } catch {
                XCTFail("error should be Webservice.Error.other(TestError.fail)")
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLoadResourceFailParsing() {
        let funcName = "testLoadResourceFailParsing"
        let resource = Resource(url: URL(string: "https://apple.com/\(funcName)")!, parse: { _ in throw TestError.fail })
        let expectation = XCTestExpectation(description: funcName)
        
        stub(condition: isPath("/\(funcName)")) { _ in
            OHHTTPStubsResponse(data: Data(), statusCode: 200, headers: nil)
        }
        
        Webservice.shared.load(resource: resource) {
            do {
                _ = try $0.get()
                XCTFail("should throw error")
            } catch Webservice.Error.parsed(TestError.fail) {
                expectation.fulfill()
            } catch {
                XCTFail("error should be Webservice.Error.parsed(TestError.fail)")
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLoadResourceWithEmptyData() {
        let funcName = "testLoadResourceWithEmptyData"
        let resource = Resource(url: URL(string: "https://apple.com/\(funcName)")!, parse: { $0 })
        let expectation = XCTestExpectation(description: funcName)
        
        stub(condition: isPath("/\(funcName)")) { _ in
            OHHTTPStubsResponse(data: Data(), statusCode: 200, headers: nil)
        }
        
        Webservice.shared.load(resource: resource) {
            switch $0 {
            case .success(let data):
                XCTAssertTrue(data.isEmpty, "data should be empty")
                expectation.fulfill()
            case .failure:
                XCTFail("expected success")
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLoadResourceCancel() {
        let funcName = "testLoadResourceCancel"
        let resource = Resource(url: URL(string: "https://apple.com/\(funcName)")!, parse: { $0 })
        let cancelToken = CancelToken()
        let expectation = XCTestExpectation(description: funcName)
        
        stub(condition: isPath("/\(funcName)")) { _ in
            OHHTTPStubsResponse(data: Data(), statusCode: 200, headers: nil)
        }
        
        Webservice.shared.load(resource: resource, token: cancelToken) {
            switch $0 {
            case .success:
                XCTFail("expected failure")
            case .failure:
                expectation.fulfill()
            }
        }
        
        cancelToken.cancel()
        
        wait(for: [expectation], timeout: 0.1)
    }
}
