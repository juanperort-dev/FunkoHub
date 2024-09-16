//
//  FunkoFilterPresenterTests.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
import XCTest
@testable import FunkoHub

class FunkoFilterPresenterTests: XCTestCase {
    
    var sut: FunkoFilterPresenter!
    
    let dateFormatter = DateFormatter()
    let minDateString = "26/12/2003"
    let maxDateString = "27/12/2003"
    var minDate: Date = Date()
    var maxDate: Date = Date()
    
    override func setUp() {
        super.setUp()
        sut = FunkoFilterPresenter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        minDate = dateFormatter.date(from: minDateString) ?? Date()
        maxDate = dateFormatter.date(from: maxDateString) ?? Date()
    }
    
    // MARK: Spies
    
    class FunkoFilterViewControllerSpy: FunkoFilterViewControllerDelegate {
        
        var showMessageAlertCalled = false
        var changeTypeListCalled = false
        var sendFilteredDataCalled = false
        var closeViewCalled = false
        var resetCheckboxCalled = false
        var setupTypeCheckboxCalled = false
        var resetDateDataCalled = false
        var resetPriceSliderDataCalled = false
        var resetPriceSliderLabelDataCalled = false
        var checkTypeCheckboxCalled = false
        var updateDateCalled = false
        var updatePriceSliderCalled = false
        var updatePriceSliderLabelCalled = false
        var changeMaxPriceLabelCalled = false
        
        func showMessageAlert() {
            showMessageAlertCalled = true
        }
        
        func changeTypeList() {
            changeTypeListCalled = true
        }
        
        func sendFilteredData() {
            sendFilteredDataCalled = true
        }
        
        func closeView() {
            closeViewCalled = true
        }
        
        func resetCheckbox() {
            resetCheckboxCalled = true
        }
        
        func setupTypeCheckbox() {
            setupTypeCheckboxCalled = true
        }
        
        func resetDateData() {
            resetDateDataCalled = true
        }
        
        func resetPriceSliderData() {
            resetPriceSliderDataCalled = true
        }
        
        func resetPriceSliderLabelData() {
            resetPriceSliderLabelDataCalled = true
        }
        
        func checkTypeCheckbox() {
            checkTypeCheckboxCalled = true
        }
        
        func updateDate() {
            updateDateCalled = true
        }
        
        func updatePriceSlider() {
            updatePriceSliderCalled = true
        }
        
        func updatePriceSliderLabel() {
            updatePriceSliderLabelCalled = true
        }
        
        func changeMaxPriceLabel(price: Double) {
            changeMaxPriceLabelCalled = true
        }
    }

    // MARK: Tests
    
    func testSetView() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        
        // When
        sut.setView(FunkoFilterViewController())
        
        // Then
        XCTAssertNotNil(sut.view)
    }
    
    func testSetupView() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        
        // When
        sut.setupView()
        
        // Then
        XCTAssertTrue(spy.setupTypeCheckboxCalled)
    }
    
    func testSelectFromDate() {
        // Given
        
        // When
        sut.selectFromDate(minDate)
        
        // Then
        XCTAssertEqual(sut.changedData.minDate, minDate)
    }
    
    func testSelectToDate() {
        // Given
        
        // When
        sut.selectToDate(maxDate)
        
        // Then
        XCTAssertEqual(sut.changedData.maxDate, maxDate)
    }
    
    func testUpdatePriceSliderMaxPrice() {
        // Given
        let price: Double = 100
        
        // When
        sut.updatePriceSlider(sliderValue: price)
        
        // Then
        XCTAssertEqual(sut.changedData.maxPrice, price)
    }
    
    func testUpdatePriceSliderRoundedMaxPrice() {
        // Given
        let price: Double = 100
        
        // When
        sut.updatePriceSlider(sliderValue: price)
        
        // Then
        XCTAssertEqual(sut.getRoundedMaxPrice(), round(price))
    }
    
    func testUpdatePriceSliderLabel() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        let price: Double = 100
        
        // When
        sut.updatePriceSlider(sliderValue: price)
        
        // Then
        XCTAssertTrue(spy.changeMaxPriceLabelCalled)
    }
    
    func testCheckValuesChangeTypeListSuccess() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        sut.changedData.minDate = minDate
        sut.changedData.maxDate = maxDate
        
        // When
        sut.checkValues()
        
        // Then
        XCTAssertTrue(spy.changeTypeListCalled)
    }
    
    func testCheckValuesSendFilteredDataSuccess() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        sut.changedData.minDate = minDate
        sut.changedData.maxDate = maxDate
        
        // When
        sut.checkValues()
        
        // Then
        XCTAssertTrue(spy.sendFilteredDataCalled)
    }
    
    func testCheckValuesCloseViewSuccess() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        sut.changedData.minDate = minDate
        sut.changedData.maxDate = maxDate
        
        // When
        sut.checkValues()
        
        // Then
        XCTAssertTrue(spy.closeViewCalled)
    }
    
    func testCheckValuesChangeTypeListFailure() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        sut.changedData.minDate = maxDate
        sut.changedData.maxDate = minDate
        
        // When
        sut.checkValues()
        
        // Then
        XCTAssertFalse(spy.changeTypeListCalled)
    }
    
    func testCheckValuesSendFilteredDataFailure() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        sut.changedData.minDate = maxDate
        sut.changedData.maxDate = minDate
        
        // When
        sut.checkValues()
        
        // Then
        XCTAssertFalse(spy.sendFilteredDataCalled)
    }
    
    func testCheckValuesCloseViewFailure() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        sut.changedData.minDate = maxDate
        sut.changedData.maxDate = minDate
        
        // When
        sut.checkValues()
        
        // Then
        XCTAssertFalse(spy.closeViewCalled)
    }
    
    func testIsValidDateSuccess() {
        // Given
        sut.changedData.minDate = minDate
        sut.changedData.maxDate = maxDate
        
        // When
        let value = sut.isValidDate()
        
        //Then
        XCTAssertTrue(value)
    }
    
    func testIsValidDateFailure() {
        // Given
        sut.changedData.minDate = maxDate
        sut.changedData.maxDate = minDate
        
        // When
        let value = sut.isValidDate()
        
        //Then
        XCTAssertFalse(value)
    }
    
    func testIsValidDateShowMessageAlertFailure() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        sut.changedData.minDate = maxDate
        sut.changedData.maxDate = minDate
        
        // When
        let _ = sut.isValidDate()
        
        //Then
        XCTAssertTrue(spy.showMessageAlertCalled)
    }
    
    func testSetupTypeList() {
        // Given
        sut.changedData.typeList = [Funko.FunkoType.AOT]
        
        // When
        sut.resetFilters()
        
        // Then
        XCTAssertEqual(sut.changedData.typeList.count, 0)
    }
    
    func testResetFiltersMinDate() {
        // Given
        sut.changedData.minDate = minDate
        sut.changedData.maxDate = maxDate
        
        // When
        sut.resetFilters()
        
        // Then
        XCTAssertEqual(sut.changedData.minDate, sut.defaultData.minDate)
    }
    
    func testResetFiltersMaxDate() {
        // Given
        sut.changedData.minDate = minDate
        sut.changedData.maxDate = maxDate
        
        // When
        sut.resetFilters()
        
        // Then
        XCTAssertEqual(sut.changedData.maxDate, sut.defaultData.maxDate)
    }
    
    func testResetFiltersMaxPrice() {
        // Given
        sut.changedData.maxPrice = 200
        
        // When
        sut.resetFilters()
        
        // Then
        XCTAssertEqual(sut.changedData.maxPrice, sut.defaultData.maxPrice)
    }
    
    func testResetFiltersMinPrice() {
        // Given
        sut.changedData.minPrice = 100
        
        // When
        sut.resetFilters()
        
        // Then
        XCTAssertEqual(sut.changedData.minPrice, sut.defaultData.minPrice)
    }
    
    func testResetFiltersTypeList() {
        // Given
        sut.changedData.typeList = [Funko.FunkoType.AOT]
        
        // When
        sut.resetFilters()
        
        // Then
        XCTAssertEqual(sut.changedData.typeList, sut.defaultData.typeList)
    }
    
    func testResetFiltersTypeListCheckbox() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        
        // When
        sut.resetFilters()
        
        // Then
        XCTAssertTrue(spy.resetCheckboxCalled)
    }
    
    func testSetupTypeCheckbox() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        
        // When
        sut.resetFilters()
        
        // Then
        XCTAssertTrue(spy.setupTypeCheckboxCalled)
    }
    
    func testResetDateData() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        
        // When
        sut.resetFilters()
        
        // Then
        XCTAssertTrue(spy.resetDateDataCalled)
    }
    
    func testResetPriceSliderData() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        
        // When
        sut.resetFilters()
        
        // Then
        XCTAssertTrue(spy.resetPriceSliderDataCalled)
    }
    
    func testResetPriceSliderLabelData() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        
        // When
        sut.resetFilters()
        
        // Then
        XCTAssertTrue(spy.resetPriceSliderLabelDataCalled)
    }
    
    func testCloseView() {
        // Given
        let spy = FunkoFilterViewControllerSpy()
        sut.view = spy
        
        // When
        sut.closeView()
        
        // Then
        XCTAssertTrue(spy.closeViewCalled)
    }
    
    func testUpdateMaxPrice() {
        // Given
        let price: Double = 100
        
        // When
        sut.updateMaxPrice(maxPrice: price)
        
        // Then
        XCTAssertEqual(sut.changedData.maxPrice, price)
    }
    
    func testUpdateRoundedMaxPrice() {
        // Given
        let price: Double = 100
        
        // When
        sut.updateMaxPrice(maxPrice: price)
        
        // Then
        XCTAssertEqual(sut.getRoundedMaxPrice(), round(price))
    }
    
    func testIsSelectedTrue() {
        // Given
        let type: Funko.FunkoType = Funko.FunkoType.AOT
        
        // When
        sut.addType(isSelected: true, type: type)
        
        // Then
        XCTAssertTrue(sut.changedData.typeList.contains(type))
    }
    
    func testIsSelectedFalse() {
        // Given
        let type: Funko.FunkoType = Funko.FunkoType.AOT
        sut.changedData.typeList = [Funko.FunkoType.AOT]
        
        // When
        sut.addType(isSelected: false, type: type)
        
        // Then
        XCTAssertFalse(sut.changedData.typeList.contains(type))
    }
    
    func testSetDefaultData() {
        // Given
        
        // When
        sut.setDefaultData(data: KeyDataFunkos())
        
        // Then
        XCTAssertNotNil(sut.defaultData)
    }
    
    func testGetDefaultData() {
        // Given
        
        // When
        let value = sut.getDefaultData()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testSetChangedData() {
        // Given
        
        // When
        sut.setChangedData(data: KeyDataFunkos())
        
        // Then
        XCTAssertNotNil(sut.changedData)
    }
    
    func testGetChangedData() {
        // Given
        
        // When
        let value = sut.getChangedData()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testGetDefaultMinDate() {
        // Given
        
        // When
        let value = sut.getDefaultMinDate()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testGetChangedMinDate() {
        // Given
        
        // When
        let value = sut.getChangedMinDate()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testSetChangedMinDate() {
        // Given
        
        // When
        sut.setChangedMinDate(date: maxDate)
        
        // Then
        XCTAssertEqual(sut.getChangedMinDate(), maxDate)
    }
    
    func testGetDefaultMaxDate() {
        // Given
        
        // When
        let value = sut.getDefaultMaxDate()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testGetChangedMaxDate() {
        // Given
        
        // When
        let value = sut.getChangedMaxDate()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testSetChangedMaxDate() {
        // Given
        
        // When
        sut.setChangedMaxDate(date: minDate)
        
        // Then
        XCTAssertEqual(sut.getChangedMaxDate(), minDate)
    }
    
    func testGetChangedMinPrice() {
        // Given
        
        // When
        let value = sut.getChangedMinPrice()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testSetChangedMinPrice() {
        // Given
        let price = 20.0
        
        // When
        sut.setChangedMinPrice(price: price)
        
        // Then
        XCTAssertEqual(sut.getChangedMinPrice(), price)
    }
    
    func testGetDefaultMinPrice() {
        // Given
        
        // When
        let value = sut.getDefaultMinPrice()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testGetDefaultMaxPrice() {
        // Given
        
        // When
        let value = sut.getDefaultMaxPrice()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testGetChangedMaxPrice() {
        // Given
        
        // When
        let value = sut.getChangedMaxPrice()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testGetDefaultTypeList() {
        // Given
        
        // When
        let value = sut.getDefaultTypeList()
        
        // Then
        XCTAssertNotNil(value)
    }
    
    func testGetChangedTypeList() {
        // Given
        
        // When
        let value = sut.getChangedTypeList()
        
        // Then
        XCTAssertNotNil(value)
    }
}
