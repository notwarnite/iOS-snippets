//
//  UnitTestViewModel_Tests.swift
//  UnitTestingSample_Tests
//
//  Created by Ritwik Singh on 17/12/23.
//

import XCTest
@testable import UnitTestingSample // import to get imports form app
import Combine


final class UnitTestViewModel_Tests: XCTestCase {
    
    var viewModel: UnitTestViewModel?
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        
        viewModel = UnitTestViewModel(isPremium: Bool.random())
        
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeTrue() {
        //Given
        let userIsPremium: Bool = true
        
        //When
        let vm = UnitTestViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeFalse() {
        //Given
        let userIsPremium: Bool = false
        
        //When
        let vm = UnitTestViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue() {
        //Given
        let userIsPremium: Bool = Bool.random()
        
        //When
        let vm = UnitTestViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue_Stress() {
        for _ in 0..<10 {
            //Given
            let userIsPremium: Bool = Bool.random()
            
            //When
            let vm = UnitTestViewModel(isPremium: userIsPremium)
            
            //Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    func test_UnitTestingViewModel_dataArray_shouldBeEmpty() {
        //Given
        
        //When
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldAddItems() {
        //Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        //When
        let counter: Int = Int.random(in: 1..<50)
        for _ in 0..<counter {
            vm.addItem(item: UUID().uuidString)
        }
        
        //Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertEqual(vm.dataArray.count, counter)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddBlankString() {
        //Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        //When
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddBlankString_2() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldStartAsNil() {
        //Given
        
        //When
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        //Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldNotNilWhenSelectingInvalidItem() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        // select valid item
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // select invalid item
        vm.selectItem(item: UUID().uuidString)
        
        //Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected() {
        //Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        //When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected_Stress() {
        //Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        //When
        let counter: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        for _ in 0..<counter{
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        //Then
        XCTAssertFalse(randomItem.isEmpty)
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingViewModel_saveItem_shouldThrowError_itemNotFound() {
        //Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        //When
        let counter: Int = Int.random(in: 1..<100)
        for _ in 0..<counter{
            vm.addItem(item: UUID().uuidString)
        }
        
        //Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw item not found error!") { error in
            let returnedError = error as? UnitTestViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestViewModel.DataError.itemNotFound)
        }
    }
    
    func test_UnitTestingViewModel_saveItem_shouldThrowError_noData() {
        //Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        //When
        let counter: Int = Int.random(in: 1..<100)
        for _ in 0..<counter{
            vm.addItem(item: UUID().uuidString)
        }
        
        //Then
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let returnedError = error as? UnitTestViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestViewModel.DataError.noData)
        }
    }
    
    func test_UnitTestingViewModel_saveItem_shouldSaveitem() {
        //Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        //When
        let counter: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        for _ in 0..<counter{
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        //Then
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }
    
    func test_UnitTestingViewModel_downloadWithEscaping_shouldReturnItems() {
        //Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        //When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")
        
        // subscriber
        vm.$dataArray
            .dropFirst() // drop the first publish (as that will be initially empty)
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithEscaping()
                
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_downloadWithCombine_shouldReturnItems() {
        //Given
        let vm = UnitTestViewModel(isPremium: Bool.random())
        
        //When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")
        
        // subscriber
        vm.$dataArray
            .dropFirst() // drop the first publish (as that will be initially empty)
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithCombine()
                
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    
}
