//
//  FunkoListViewControllerTests.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
import XCTest
@testable import FunkoHub

class FunkoListViewControllerTests: XCTestCase {

    var sut: FunkoListViewController!
    let presenter = FunkoListPresenter()

    override func setUp() {
        super.setUp()
        setupFunkoListViewController()
    }
    
    // MARK: Test setup

    func setupFunkoListViewController() {
        let list = UIStoryboard(name: Constants.Storyboard.funkoList, bundle: nil)
        sut = list.instantiateViewController(withIdentifier: Constants.Storyboard.funkoList) as? FunkoListViewController
    }
    
    // MARK: Spies
    
    class FunkoListPresenterLogicSpy: FunkoListPresenterDelegate {
        
        var backButtonActionCalled = false
        var didSelectRowAtCalled = false
        var getNumberOfRowsCalled = false
        var updateViewCalled = false
        var getDefaultValueCalled = false
        var getCellDataCalled = false
        
        var presenter: FunkoListPresenter?
        
        init(presenter: FunkoListPresenter) {
            self.presenter = presenter
        }
        
        func backButtonAction() {
            backButtonActionCalled = true
            presenter?.backButtonAction()
        }
        
        func didSelectRowAt(index: Int) {
            didSelectRowAtCalled = true
            presenter?.didSelectRowAt(index: index)
        }
        
        func getNumberOfRows() -> Int {
            getNumberOfRowsCalled = true
            return presenter?.getNumberOfRows() ?? 0
        }
        
        func updateView() {
            updateViewCalled = true
            presenter?.updateView()
        }
        
        func getDefaultValue() {
            getDefaultValueCalled = true
            presenter?.getDefaultValue()
        }
        
        func getCellData(index: Int) -> FunkoHub.Funko {
            getCellDataCalled = true
            return presenter?.getCellData(index: index) ?? Funko(name: "test", type: .AOT, price: 0.0, date: Date())
        }
    }
    
    // MARK: Tests
}


