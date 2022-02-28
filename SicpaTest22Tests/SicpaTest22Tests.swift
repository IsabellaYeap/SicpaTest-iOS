//
//  SicpaTest22Tests.swift
//  SicpaTest22Tests
//
//  Created by Yeap Pei Ting on 27/02/2022.
//

import XCTest
@testable import SicpaTest22

class SicpaTest22Tests: XCTestCase {
    
    let period = String(Period.today.rawValue)
    let shareType = ShareType.facebook.rawValue
    let path = "https://api.nytimes.com/svc/mostpopular/v2/"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testBasicRequestGeneration() throws {
        let request = ArticleEndpoint.indexOfEmailed(params: nil, path: period)
        let operation = APIOperation(request)
        let urlRequest = operation.request.urlRequest(with: APIEnvironment.Nytimes)
        
        XCTAssertEqual(
            urlRequest?.url,
            URL(string: "\(path)emailed/\(period).json")
        )
    }
    
    func testGeneratingRequestWithQueryItems() throws {
        let params = [
            "api-key": AppSetting.nytimesApiKey
        ] as RequestParameters
        let request = ArticleEndpoint.indexOfEmailed(params: params, path: period)
        let operation = APIOperation(request)
        let urlRequest = operation.request.urlRequest(with: APIEnvironment.Nytimes)
        
        XCTAssertEqual(
            urlRequest?.url,
            URL(string: "\(path)emailed/\(period).json?api-key=\(AppSetting.nytimesApiKey)")
        )
    }
    
    func testSuccessfullyPerformingRequest() throws {
        
    }
    
    func testFailingWhenEncounteringError() throws {
        
    }

}
