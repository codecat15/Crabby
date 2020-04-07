//
//  DateExtensionsTests.swift
//  CrabbyTests
//
//  Created by CodeCat15 on 4/7/20.
//  Copyright © 2020 Crabby. All rights reserved.
//

import XCTest
@testable import Crabby

class DateExtensionsTests: XCTestCase {

    //MARK: - toString
    func test_toString_WithValidData_Returns_StringDate()
    {
        //ARRANGE
        let value = Date();

        //ACT
        let result = value.toString(dateFormat: DateFormats.Format_yyyy_MM_dd, expectedTimeZone: nil);

        //ASSERT
        XCTAssertNotNil(result);
    }

    func test_toString_WithValidData_InvalidDateFormat_Returns_Integer()
    {
        //ARRANGE
        let value = Date();

        //ACT
        let result = value.toString(dateFormat: "HelloWorld", expectedTimeZone: nil);

        //ASSERT
        XCTAssertNotNil(Int(result)); // because invalid date format returns integer
    }

    func test_toString_WithValidData_ValidTimeZone_Returns_StringDate()
    {
        //ARRANGE
        let value = Date();
        let format = DateFormats.Format_yyyy_MM_dd

        //ACT
        let result = value.toString(dateFormat: format, expectedTimeZone: TimeZone(identifier: "UTC"));

        let reverseConversion = try! result.toDate(dateFormat: format, expectedTimeZone: TimeZone(identifier: "UTC"))

        let order = Calendar.current.compare(value, to: reverseConversion, toGranularity: .timeZone)

        //ASSERT
        XCTAssertNotNil(result);
        XCTAssertTrue(order == .orderedSame)
    }

    func test_toString_With_Nil_DateString_And_Nil_TimeZone_Returns_StringDate()
    {
        //ARRANGE
        let value = Date();

        //ACT
        let result = value.toString(dateFormat: nil, expectedTimeZone: nil);

        //ASSERT
        XCTAssertNotNil(result);

    }

    func test_toString_With_CST_TimeZone_Returns_StringDate_Of_CST_TimeZone()
    {
        //ARRANGE
        let value = Date();
         let format = DateFormats.Format_MM_dd_yyyy_With_HH_mm_ss

        //ACT
        let result = value.toString(dateFormat: nil, expectedTimeZone: TimeZone(identifier: "CST"));

        let reverseConversion = try! result.toDate(dateFormat: format, expectedTimeZone: TimeZone(identifier: "CST"))

        let order = Calendar.current.compare(value, to: reverseConversion, toGranularity: .timeZone)

        //ASSERT
        XCTAssertNotNil(result);
        XCTAssertTrue(order == .orderedSame)

    }

    //MARK: - addDaysToDate

    func test_addDaysToDate_AddingOneDayToCurrentDate_Returns_DateIncrementedWithOne()
    {
        //ACT
        let currentDate = Date()
        let result = currentDate.addDaysToDate(daysToAdd: 1)
        let components = Calendar.current.dateComponents([.day], from: currentDate, to: result!)

        //ASSERT
        XCTAssertNotNil(result)
        XCTAssertTrue(components.day == 1)

    }

    func test_addDaysToDate_SubtractingTenDaysToCurrentDate_Returns_DateSubtractedWithTen()
    {
        //ACT
        let currentDate = Date()
        let result = currentDate.addDaysToDate(daysToAdd: -10)
        let components = Calendar.current.dateComponents([.day], from: currentDate, to: result!)

        //ASSERT
        XCTAssertNotNil(result)
        XCTAssertTrue(components.day == -10)
    }

    func test_addDaysToDate_AddingZeroDays_Returns_SameDate()
    {
        //ACT
        let currentDate = Date()
        let result = currentDate.addDaysToDate(daysToAdd: 0)
        let components = Calendar.current.dateComponents([.day], from: currentDate, to: result!)

        //ASSERT
        XCTAssertNotNil(result)
        XCTAssertTrue(components.day == 0)
        XCTAssertTrue(currentDate == result!)

    }

    func test_addDaysToDate_YearCheck_Returns_SameDate()
    {
        //ARRANGE
        let calender = Calendar.current

        //ACT
        let JanDate = "01-01-2019".toDate(dateFormat: "dd/MM/yyyy")
        let pastDate = JanDate!.addDaysToDate(daysToAdd: -15)
        let components = Calendar.current.dateComponents([.day], from: JanDate!, to: pastDate!)

        //ASSERT
        XCTAssertNotNil(components)
        XCTAssertTrue(components.day == -15)
        XCTAssertTrue(calender.component(.year, from: pastDate!) == 2018)
        XCTAssertTrue(calender.component(.month, from: pastDate!) == 12)

    }

}
