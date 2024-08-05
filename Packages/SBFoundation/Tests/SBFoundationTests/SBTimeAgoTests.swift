import XCTest
@testable import SBFoundation

final class SBTimeAgoTests: XCTestCase {
    func test_oneWeek_ago_dateStrings() {
        let oneWeekAgo = SBTimeAgo.oneWeek.dateRange
        let calendar = Calendar.current
        let expectedMinDate = calendar.date(byAdding: .weekOfYear, value: -1, to: Date())!
        let expectedMaxDate = calendar.date(byAdding: .day, value: 7, to: expectedMinDate)!
        let actualMinDateString = oneWeekAgo.minDate.formattedDateString()
        let actualMaxDateString = oneWeekAgo.maxDate.formattedDateString()
        let expectedMinDateString = expectedMinDate.formattedDateString()
        let expectedMaxDateString = expectedMaxDate.formattedDateString()
        XCTAssertEqual(actualMinDateString, expectedMinDateString, "The minDate string for one week ago is incorrect.")
        XCTAssertEqual(actualMaxDateString, expectedMaxDateString, "The maxDate string for one week ago is incorrect.")
    }
    
    func test_twoWeeks_ago_dateStrings() {
        let twoWeeksAgo = SBTimeAgo.twoWeeks.dateRange
        let calendar = Calendar.current
        let expectedMinDate = calendar.date(byAdding: .weekOfYear, value: -2, to: Date())!
        let expectedMaxDate = calendar.date(byAdding: .day, value: 7, to: expectedMinDate)!
        let actualMinDateString = twoWeeksAgo.minDate.formattedDateString()
        let actualMaxDateString = twoWeeksAgo.maxDate.formattedDateString()
        let expectedMinDateString = expectedMinDate.formattedDateString()
        let expectedMaxDateString = expectedMaxDate.formattedDateString()
        XCTAssertEqual(actualMinDateString, expectedMinDateString, "The minDate string for two weeks ago is incorrect.")
        XCTAssertEqual(actualMaxDateString, expectedMaxDateString, "The maxDate string for two weeks ago is incorrect.")
    }
    
    func test_threeWeeks_ago_dateStrings() {
        let threeWeeksAgo = SBTimeAgo.threeWeeks.dateRange
        let calendar = Calendar.current
        let expectedMinDate = calendar.date(byAdding: .weekOfYear, value: -3, to: Date())!
        let expectedMaxDate = calendar.date(byAdding: .day, value: 7, to: expectedMinDate)!
        let actualMinDateString = threeWeeksAgo.minDate.formattedDateString()
        let actualMaxDateString = threeWeeksAgo.maxDate.formattedDateString()
        let expectedMinDateString = expectedMinDate.formattedDateString()
        let expectedMaxDateString = expectedMaxDate.formattedDateString()
        XCTAssertEqual(actualMinDateString, expectedMinDateString, "The minDate string for three weeks ago is incorrect.")
        XCTAssertEqual(actualMaxDateString, expectedMaxDateString, "The maxDate string for three weeks ago is incorrect.")
    }
    
    func test_fourWeeks_ago_dateStrings() {
        let fourWeeksAgo = SBTimeAgo.fourWeeks.dateRange
        let calendar = Calendar.current
        let expectedMinDate = calendar.date(byAdding: .weekOfYear, value: -4, to: Date())!
        let expectedMaxDate = calendar.date(byAdding: .day, value: 7, to: expectedMinDate)!
        let actualMinDateString = fourWeeksAgo.minDate.formattedDateString()
        let actualMaxDateString = fourWeeksAgo.maxDate.formattedDateString()
        let expectedMinDateString = expectedMinDate.formattedDateString()
        let expectedMaxDateString = expectedMaxDate.formattedDateString()
        XCTAssertEqual(actualMinDateString, expectedMinDateString, "The minDate string for four weeks ago is incorrect.")
        XCTAssertEqual(actualMaxDateString, expectedMaxDateString, "The maxDate string for four weeks ago is incorrect.")
    }
}
