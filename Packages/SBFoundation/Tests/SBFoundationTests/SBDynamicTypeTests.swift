import XCTest
@testable import SBFoundation

final class SBDynamicTypeTests: XCTestCase {
    var sut: SBDynamicType<Int>!
    
    override func setUp() {
        self.sut = .init(value: 10)
    }
    
    override func tearDown() {
        self.sut = nil
    }
    
    func testInit_with_10_sets_10_as_correct_value() {
        let expectedInitialValue = 10
        XCTAssertEqual(sut.value, expectedInitialValue, "The initial value should be set correctly.")
    }
    
    func testValue_change_triggers_listener() {
        let expectation = self.expectation(description: "Listener should be triggered when value changes")
        var capturedValue: Int?
        sut.bind { newValue in
            capturedValue = newValue
            expectation.fulfill()
        }
        sut.value = 11
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(capturedValue, 11, "The listener should be triggered with the updated value.")
        }
    }
    
    func testValue_changes_with_multiple_changes_triggers_listener() {
        let expectation1 = self.expectation(description: "First listener trigger")
        let expectation2 = self.expectation(description: "Second listener trigger")
        var capturedValues: [Int] = []
        sut.bind { newValue in
            capturedValues.append(newValue)
            if newValue == 12 {
                expectation1.fulfill()
            }
            if newValue == 13 {
                expectation2.fulfill()
            }
        }
        sut.value = 12
        sut.value = 13
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(capturedValues, [12, 13], "The listener should be triggered with the correct sequence of updated values.")
        }
    }
    
    func testListener_not_triggered_after_unbinding() {
        var listenerCalled = false
        sut.bind { _ in
            listenerCalled = true
        }
        sut.listener = nil
        sut.value = 99
        XCTAssertFalse(listenerCalled, "Listener should not be called after being unbound.")
    }
}
