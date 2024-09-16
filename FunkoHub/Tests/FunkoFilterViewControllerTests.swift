//
//  FunkoFilterViewControllerTests.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
import XCTest
@testable import FunkoHub

class FunkoFilterViewControllerTests: XCTestCase {

    var sut: FunkoFilterViewController!

    let dateFormatter = DateFormatter()
    let dateString = "27/12/2003"
    var minDate: Date = Date()

    override func setUp() {
        super.setUp()
        setupFilterViewController()

        dateFormatter.dateFormat = Constants.Pattern.date
        minDate = dateFormatter.date(from: dateString)!
    }
    
    // MARK: Test setup

    func setupFilterViewController() {
        let filter = UIStoryboard(name: Constants.Storyboard.funkoFilter, bundle: nil)
        sut = filter.instantiateViewController(withIdentifier: Constants.Storyboard.funkoFilter) as? FunkoFilterViewController
    }
    
    // MARK: Spies
    
    class FunkoFilterPresenterLogicSpy: FunkoFilterPresenterDelegate {
        
        var setupViewCalled = false
        var selectFromDateCalled = false
        var selectToDateCalled = false
        var updatePriceSliderCalled = false
        var checkValuesCalled = false
        var resetFiltersCalled = false
        var closeViewCalled = false
        var addTypeCalled = false
        var setDefaultDataCalled = false
        var getDefaultDataCalled = false
        var setChangedDataCalled = false
        var getChangedDataCalled = false
        var getDefaultMinDateCalled = false
        var getChangedMinDateCalled = false
        var getDefaultMaxDateCalled = false
        var getChangedMaxDateCalled = false
        var getDefaultMinPriceCalled = false
        var getChangedMinPriceCalled = false
        var getDefaultMaxPriceCalled = false
        var getChangedMaxPriceCalled = false
        var getDefaultTypeListCalled = false
        var getChangedTypeListCalled = false
        var setViewCalled = false
        
        func setupView() {
            setupViewCalled = true
        }
        
        func selectFromDate(_ sender: Date) {
            selectFromDateCalled = true
        }
        
        func selectToDate(_ sender: Date) {
            selectToDateCalled = true
        }
        
        func updatePriceSlider(sliderValue: Double) {
            updatePriceSliderCalled = true
        }
        
        func checkValues() {
            checkValuesCalled = true
        }
        
        func resetFilters() {
            resetFiltersCalled = true
        }
        
        func closeView() {
            closeViewCalled = true
        }
        
        func addType(isSelected: Bool, type: Funko.FunkoType) {
            addTypeCalled = true
        }
        
        func setDefaultData(data: KeyDataFunkos) {
            setDefaultDataCalled = true
        }
        
        func getDefaultData() -> KeyDataFunkos {
            getDefaultDataCalled = true
            return KeyDataFunkos()
        }
        
        func setChangedData(data: KeyDataFunkos) {
            setChangedDataCalled = true
        }
        
        func getChangedData() -> KeyDataFunkos {
            getChangedDataCalled = true
            return KeyDataFunkos()
        }
        
        func getDefaultMinDate() -> Date {
            getDefaultMinDateCalled = true
            return Date()
        }
        
        func getChangedMinDate() -> Date {
            getChangedMinDateCalled = true
            return Date()
        }
        
        func getDefaultMaxDate() -> Date {
            getDefaultMaxDateCalled = true
            return Date()
        }
        
        func getChangedMaxDate() -> Date {
            getChangedMaxDateCalled = true
            return Date()
        }
        
        func getDefaultMinPrice() -> Double {
            getDefaultMinPriceCalled = true
            return Double()
        }
        
        func getChangedMinPrice() -> Double {
            getChangedMinPriceCalled = true
            return Double()
        }
        
        func getDefaultMaxPrice() -> Double {
            getDefaultMaxPriceCalled = true
            return Double()
        }
        
        func getChangedMaxPrice() -> Double {
            getChangedMaxPriceCalled = true
            return Double()
        }
        
        func getDefaultTypeList() -> [Funko.FunkoType] {
            getDefaultTypeListCalled = true
            return []
        }
        
        func getChangedTypeList() -> [Funko.FunkoType] {
            getChangedTypeListCalled = true
            return []
        }
        
        func setView(_ delegate: any FunkoFilterViewControllerDelegate) {
            setViewCalled = true
        }
    }
    
    // MARK: Tests
    
    func testViewDidLoad() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        
        // When
        sut.viewDidLoad()

        // Then
        XCTAssertTrue(spy.setupViewCalled)
    }

    func testFromDatePickerAction() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let datePicker: UIDatePicker = UIDatePicker()

        // When
        sut.fromDatePickerAction(datePicker)

        // Then
        XCTAssertTrue(spy.selectFromDateCalled)
    }

    func testToDatePickerAction() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let datePicker: UIDatePicker = UIDatePicker()

        // When
        sut.toDatePickerAction(datePicker)

        // Then
        XCTAssertTrue(spy.selectToDateCalled)
    }

    func testPriceSliderAction() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let slider: UISlider = UISlider()

        // When
        sut.priceSliderAction(slider)

        // Then
        XCTAssertTrue(spy.updatePriceSliderCalled)
    }

    func testApplyButtonAction() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let button: UIButton = UIButton()

        // When
        sut.applyButtonAction(button)

        // Then
        XCTAssertTrue(spy.checkValuesCalled)
    }

    func testDeleteButtonAction() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let button: UIButton = UIButton()

        // When
        sut.deleteButtonAction(button)

        // Then
        XCTAssertTrue(spy.resetFiltersCalled)
    }

    func testCloseButtonAction() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let button: UIButton = UIButton()

        // When
        sut.closeButtonAction(button)

        // Then
        XCTAssertTrue(spy.closeViewCalled)
    }
    
    func testSetupTypeCheckbox() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy

        // When
        sut.setupTypeCheckbox()

        // Then
        XCTAssertTrue(spy.getDefaultTypeListCalled)
    }

    func testUpdateFromDatePicker() {
        // Given
        let datePicker: UIDatePicker = UIDatePicker()

        sut.fromDatePicker = datePicker
        sut.toDatePicker = datePicker

        // When
        sut.updateDate()

        // Then
        XCTAssertNotEqual(sut.fromDatePicker.date, minDate)
    }

    func testUpdateToDatePicker() {
        // Given
        let datePicker: UIDatePicker = UIDatePicker()

        sut.fromDatePicker = datePicker
        sut.toDatePicker = datePicker

        // When
        sut.updateDate()

        // Then
        XCTAssertNotEqual(sut.toDatePicker.date, minDate)
    }

    func testGetChangedMinDate() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let datePicker: UIDatePicker = UIDatePicker()
        sut.fromDatePicker = datePicker
        sut.toDatePicker = datePicker

        // When
        sut.updateDate()

        // Then
        XCTAssertTrue(spy.getChangedMinDateCalled)
    }

    func testGetChangedMaxDate() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let datePicker: UIDatePicker = UIDatePicker()
        sut.fromDatePicker = datePicker
        sut.toDatePicker = datePicker

        // When
        sut.updateDate()

        // Then
        XCTAssertTrue(spy.getChangedMaxDateCalled)
    }

    func testUpdateMinPriceSlider() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let slider: UISlider = UISlider()
        sut.priceSlider = slider

        // When
        sut.updatePriceSlider()

        // Then
        XCTAssertEqual(sut.priceSlider.minimumValue, Float(spy.getChangedMinPrice()))
    }

    func testUpdateMaxPriceSlider() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let slider: UISlider = UISlider()
        sut.priceSlider = slider

        // When
        sut.updatePriceSlider()

        // Then
        XCTAssertEqual(sut.priceSlider.maximumValue, Float(spy.getDefaultMaxPrice()))
    }

    func testUpdateValuePriceSlider() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let slider: UISlider = UISlider()
        sut.priceSlider = slider

        // When
        sut.updatePriceSlider()

        // Then
        XCTAssertEqual(sut.priceSlider.value, Float(spy.getChangedMaxPrice()))
    }

    func testGetChangedMinPrice() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let slider: UISlider = UISlider()
        sut.priceSlider = slider

        // When
        sut.updatePriceSlider()

        // Then
        XCTAssertTrue(spy.getChangedMinPriceCalled)
    }

    func testGetDefaultMaxPrice() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let slider: UISlider = UISlider()
        sut.priceSlider = slider

        // When
        sut.updatePriceSlider()

        // Then
        XCTAssertTrue(spy.getDefaultMaxPriceCalled)
    }

    func testGetChangedMaxPrice() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let slider: UISlider = UISlider()
        sut.priceSlider = slider

        // When
        sut.updatePriceSlider()

        // Then
        XCTAssertTrue(spy.getChangedMaxPriceCalled)
    }

    func testUpdateSelectedMinPriceSliderLabel() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let label: UILabel = UILabel()

        sut.selectedMinPriceLabel = label
        sut.selectedMaxPriceLabel = label
        sut.maxPriceLabel = label
        sut.minPriceLabel = label

        // When
        sut.updatePriceSliderLabel()

        // Then
        XCTAssertEqual(sut.selectedMinPriceLabel.text, String(spy.getChangedMinPrice()))
    }

    func testUpdateSelectedRoundedMaxPriceSliderLabel() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let label: UILabel = UILabel()

        sut.selectedMinPriceLabel = label
        sut.selectedMaxPriceLabel = label
        sut.maxPriceLabel = label
        sut.minPriceLabel = label

        // When
        sut.updatePriceSliderLabel()

        // Then
        XCTAssertEqual(sut.selectedMaxPriceLabel.text, String(round(spy.getChangedMaxPrice())))
    }

    func testUpdateMaxPriceSliderLabel() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let label: UILabel = UILabel()

        sut.selectedMinPriceLabel = label
        sut.selectedMaxPriceLabel = label
        sut.maxPriceLabel = label
        sut.minPriceLabel = label


        // When
        sut.updatePriceSliderLabel()

        // Then
        XCTAssertEqual(sut.maxPriceLabel.text, String(spy.getDefaultMaxPrice()))
    }

    func testUpdateMinPriceSliderLabel() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let label: UILabel = UILabel()

        sut.selectedMinPriceLabel = label
        sut.selectedMaxPriceLabel = label
        sut.maxPriceLabel = label
        sut.minPriceLabel = label

        // When
        sut.updatePriceSliderLabel()

        // Then
        XCTAssertEqual(sut.minPriceLabel.text, String(spy.getChangedMinPrice()))
    }

    func testUpdateChangedMinPriceSlider() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let label: UILabel = UILabel()

        sut.selectedMinPriceLabel = label
        sut.selectedMaxPriceLabel = label
        sut.maxPriceLabel = label
        sut.minPriceLabel = label

        // When
        sut.updatePriceSliderLabel()

        // Then
        XCTAssertTrue(spy.getChangedMinPriceCalled)
    }

    func testUpdateChangedMaxPriceSlider() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let label: UILabel = UILabel()

        sut.selectedMinPriceLabel = label
        sut.selectedMaxPriceLabel = label
        sut.maxPriceLabel = label
        sut.minPriceLabel = label

        // When
        sut.updatePriceSliderLabel()

        // Then
        XCTAssertTrue(spy.getChangedMaxPriceCalled)
    }

    func testUpdateDefaultMaxPriceSlider() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let label: UILabel = UILabel()

        sut.selectedMinPriceLabel = label
        sut.selectedMaxPriceLabel = label
        sut.maxPriceLabel = label
        sut.minPriceLabel = label

        // When
        sut.updatePriceSliderLabel()

        // Then
        XCTAssertTrue(spy.getDefaultMaxPriceCalled)
    }

    func testUpdateSelectedMaxPriceSliderLabel() {
        // Given
        let label: UILabel = UILabel()
        sut.selectedMaxPriceLabel = label
        let price: Double = 100

        // When
        sut.changeMaxPriceLabel(price: price)

        // Then
        XCTAssertEqual(sut.selectedMaxPriceLabel.text, String(price))
    }

    func testAddTypeSuccess() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let checkboxView: CheckboxView = CheckboxView()
        checkboxView.isSelected = true

        let type: Funko.FunkoType = Funko.FunkoType.AOT

        // When
        sut.addType(checkboxView: checkboxView, newType: type)

        // Then
        XCTAssertTrue(spy.addTypeCalled)
    }

    func testAddTypeFailure() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let chechboxView: CheckboxView = CheckboxView()
        chechboxView.isSelected = false

        let type: Funko.FunkoType = Funko.FunkoType.AOT

        // When
        sut.addType(checkboxView: chechboxView, newType: type)

        // Then
        XCTAssertFalse(spy.getChangedTypeList().contains(type))
    }

    func testResetToDate() {
        // Given
        let datePicker: UIDatePicker = UIDatePicker()

        sut.fromDatePicker = datePicker
        sut.toDatePicker = datePicker

        // When
        sut.resetDateData()

        // Then
        XCTAssertNotEqual(sut.toDatePicker.date, minDate)
    }

    func testResetFromDate() {
        // Given
        let datePicker: UIDatePicker = UIDatePicker()

        sut.fromDatePicker = datePicker
        sut.toDatePicker = datePicker

        // When
        sut.resetDateData()

        // Then
        XCTAssertNotEqual(sut.toDatePicker.date, minDate)
    }

    func testResetMinDate() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let datePicker: UIDatePicker = UIDatePicker()

        sut.fromDatePicker = datePicker
        sut.toDatePicker = datePicker

        // When
        sut.resetDateData()

        // Then
        XCTAssertTrue(spy.getDefaultMinDateCalled)
    }

    func testResetMaxDate() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let datePicker: UIDatePicker = UIDatePicker()

        sut.fromDatePicker = datePicker
        sut.toDatePicker = datePicker

        // When
        sut.resetDateData()

        // Then
        XCTAssertTrue(spy.getDefaultMaxDateCalled)
    }
    
    func testResetMaxPrice() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let slider: UISlider = UISlider()
        sut.priceSlider = slider

        // When
        sut.resetPriceSliderData()

        // Then
        XCTAssertTrue(spy.getDefaultMaxPriceCalled)
    }

    func testResetMinPrice() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let slider: UISlider = UISlider()
        sut.priceSlider = slider

        // When
        sut.resetPriceSliderData()

        // Then
        XCTAssertTrue(spy.getDefaultMinPriceCalled)
    }

    func testResetMaxPriceLabel() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let label: UILabel = UILabel()

        sut.maxPriceLabel = label
        sut.minPriceLabel = label
        sut.selectedMaxPriceLabel = label


        // When
        sut.resetPriceSliderLabelData()

        // Then
        XCTAssertEqual(sut.maxPriceLabel.text, String(spy.getDefaultMaxPrice()))
    }

    func testResetMinPriceLabel() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let label: UILabel = UILabel()

        sut.maxPriceLabel = label
        sut.minPriceLabel = label
        sut.selectedMaxPriceLabel = label

        // When
        sut.resetPriceSliderLabelData()

        // Then
        XCTAssertEqual(sut.minPriceLabel.text, String(spy.getDefaultMinPrice()))
    }

    func testResetSelectedMaxPriceLabel() {
        // Given
        let spy = FunkoFilterPresenterLogicSpy()
        sut.presenter = spy
        let label: UILabel = UILabel()

        sut.maxPriceLabel = label
        sut.minPriceLabel = label
        sut.selectedMaxPriceLabel = label

        // When
        sut.resetPriceSliderLabelData()

        // Then
        XCTAssertEqual(sut.selectedMaxPriceLabel.text, String(spy.getDefaultMaxPrice()))
    }
}
