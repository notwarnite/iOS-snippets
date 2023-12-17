//
//  NewMockDataService_Tests.swift
//  UnitTestingSample_Tests
//
//  Created by Ritwik Singh on 17/12/23.
//

import XCTest
@testable import UnitTestingSample // import to get imports form app
import Combine


final class NewMockDataService_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.removeAll()
    }
    
    func test_NewMockDataService_init_setValuesCorrectly() {
        //Given
        let items: [String]? = nil
        
        //When
        let dataService = NewMockDataService(items: items)
        
        //Then
        // should have default items
        XCTAssertFalse(dataService.items.isEmpty)
    }
    
    func test_NewMockDataService_init_doesSetValuesCorrectly() {
        //Given
        let items1: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString, UUID().uuidString]
        
        //When
        let dataService1 = NewMockDataService(items: items1)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)
        
        //Then
        XCTAssertFalse(dataService1.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, 3)
    }
    
    func test_NewMockDataService_downloadWithEscaping_doesReturnValues() {
        //Given
        let dataService = NewMockDataService(items: nil)
        
        //When
        var items: [String] = []
        let expectation = XCTestExpectation()
        dataService.downloadItemWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
        
    }
    
    func test_NewMockDataService_downloadWithCombine_doesReturnValues() {
        //Given
        let dataService = NewMockDataService(items: nil)
        
        //When
        var items: [String] = []
        let expectation = XCTestExpectation()
        dataService.downloadItemsWithCombine()
            .sink{ completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }.store(in: &cancellables)
        
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
        
    }
    
    func test_NewMockDataService_downloadWithCombine_doesFail() {
        //Given
        let dataService = NewMockDataService(items: [])
        
        //When
        var items: [String] = []
        let expectation1 = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw URL error - bad server response")
        dataService.downloadItemsWithCombine()
            .sink{ completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation1.fulfill()
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    if urlError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }.store(in: &cancellables)
        
        
        //Then
        wait(for: [expectation1, expectation2], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
        
    }
}
