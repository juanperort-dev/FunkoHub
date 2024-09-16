//
//  FunkoListPresenterTests.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
import XCTest
@testable import FunkoHub

class FunkoListPresenterTests: XCTestCase {
    
    var sut: FunkoListPresenter!
    
    override func setUp() {
        super.setUp()
        sut = FunkoListPresenter()
    }
    
    // MARK: Spies
    
    class FunkoListViewControllerSpy: FunkoListViewControllerDelegate {
        
        var navigateToFilterCalled = false
        var navigateToDetailCalled = false
        var updateTableViewCalled = false
        var setupTableViewCalled = false
        var setupDefaultValueCalled = false
        var showTableViewCalled = false
        
        func navigateToFilter(defaultData: FunkoHub.KeyDataFunkos, filteredData: FunkoHub.KeyDataFunkos) {
            navigateToFilterCalled = true
        }
        
        func navigateToDetail(index: Int) {
            navigateToDetailCalled = true
        }
        
        func updateTableView() {
            updateTableViewCalled = true
        }
        
        func setupTableView() {
            setupTableViewCalled = true
        }
        
        func setupDefaultValue() {
            setupDefaultValueCalled = true
        }
        
        func showTableView() {
            showTableViewCalled = true
        }
    }
    
    // MARK: Tests
    
    func testSendData() {
        // Given
        let spy = FunkoListViewControllerSpy()
        sut.view = spy
        let repo = FunkoNativeAPIRepositorySpy()
        sut.repository = repo
        
        // When
        sut.getDefaultValue()
        sut.sendData(data: KeyDataFunkos(funkoList: [Funko(name: "test", type: .AOT, price: 0.0, date: Date())]))
        
        // Then
        XCTAssertNotNil(spy.updateTableViewCalled)
    }
    
    func testUpdateView() {
        // Given
        let spy = FunkoListViewControllerSpy()
        sut.view = spy
        
        // When
        sut.updateView()
        
        // Then
        XCTAssertTrue(spy.setupDefaultValueCalled)
    }
    
    func testGetDefaultValue() {
        // Given
        let spy = FunkoListViewControllerSpy()
        sut.view = spy
        let repo = FunkoNativeAPIRepositorySpy()
        sut.repository = repo
        
        // When
        let value = sut.getDefaultValue()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testGetNumberOfRows() {
        // Given
        let spy = FunkoListViewControllerSpy()
        sut.view = spy
        
        // When
        let value = sut.getNumberOfRows()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testGetCellData() {
        // Given
        let spy = FunkoListViewControllerSpy()
        sut.view = spy
        let repo = FunkoNativeAPIRepositorySpy()
        sut.repository = repo
        
        // When
        sut.getDefaultValue()
        let value = sut.getCellData(index: 0)
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testBackButtonAction() {
        // Given
        let spy = FunkoListViewControllerSpy()
        sut.view = spy
        
        // When
        sut.backButtonAction()
        
        // Then
        XCTAssertTrue(spy.navigateToFilterCalled)
    }
    
    func testDidSelectRowAt() {
        // Given
        let spy = FunkoListViewControllerSpy()
        sut.view = spy
        
        // When
        sut.didSelectRowAt(index: 0)
        
        // Then
        XCTAssertTrue(spy.navigateToDetailCalled)
    }
}


