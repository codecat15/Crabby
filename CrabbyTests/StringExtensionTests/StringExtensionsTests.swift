//
//  StringExtensionsTests.swift
//  CrabbyTests
//
//  Created by CodeCat15 on 4/7/20.
//  Copyright © 2020 Crabby. All rights reserved.
//

import XCTest
@testable import Crabby

class StringExtensionsTests: XCTestCase {

    //TODO: Test for nullable strings
    //    func test_isEmpty_WithOptionalType_ThrowsException()
    //    {
    //        //ARRANGE
    //        let value : String? = nil;
    //
    //        //ASSERT
    //        XCTAssertThrowsError(try value!.isEmpty(), "some message")
    //
    //    }

    //MARK: - isValidEmail

    func test_isValidEmail_DefaultValue_Returns_True()
    {
        //ARRANGE
        let value = "test@test.com";

        //ACT
        let result = value.isValidEmail();

        //ASSERT
        XCTAssertTrue(result);
    }

    func test_isValidEmail_Multiple_Valid_Email_Values_Returns_True()
    {
        //ARRANGE
        //Source of email pattern: https://en.wikipedia.org/wiki/Email_address
        let value = ["test@test.com",
                     "test@test.co.in",
                     "very.common@example.com",
                     "other.email-with-hyphen@example.com",
                     "x@example.com",
                     "example-indeed@strange-example.com",
                     "first.last@example.com",
                     "disposable.style.email.with_symbol@example.com"];

        //ASSERT
        value.forEach { (emailId) in
            XCTAssertTrue(emailId.isValidEmail())
        }
    }

    func test_isValidEmail_Multiple_Invalid_Email_Values_Returns_False()
    {
        //ARRANGE
        //Source of email pattern: https://en.wikipedia.org/wiki/Email_address
        let value = ["Abc.example.com",
                     "A@b@c@example.com",
                     "just\not\"\"right@example.com",
                     "this is\"\not\\allowed@example.com",
                     "first.last@example..com",
                     "a\"b(c)d,e:f;g<h>i[jk]l@example.com",
                     "garbage@",
                     "HelloWorld"];

        //ASSERT
        value.forEach { (emailId) in
            XCTAssertFalse(emailId.isValidEmail())
        }
    }

    //MARK: - toURL
    func test_toURL_Invalid_String_Throws_Exception()
    {
        //ARRANGE
        let value = "@#EDFRETWER#%^&";

        //ASSERT

        XCTAssertThrowsError(try value.toURL()) { error in
            guard case StringExtensionException.invalidFormat(let value) = error else {
                return XCTFail("Different exception occured other than invalidFormat")
            }
            XCTAssertEqual(value, "string provided for conversion to URL is not a valid string");
        }
    }

    func test_toURL_Valid_String__Returns_ConvertedURLFromString()
    {
        //ARRANGE
        let value = "www.somewebsiteName.com";

        //ACT
        let result = try! value.toURL();

        //ASSERT
        XCTAssertNotNil(result);
    }

    //MARK: - toDate

    func test_toDate_With_Valid_Format_Returns_ConvertedDate()
    {
        //ARRANGE
        let value = "2018-12-25";

        //ACT
        let result = try! value.toDate(dateFormat: DateFormats.Format_yyyy_MM_dd, expectedTimeZone: nil)

        let reverseConversion = result.toString(dateFormat: DateFormats.Format_yyyy_MM_dd, expectedTimeZone: nil)

        //ASSERT
        XCTAssertNotNil(result);
        XCTAssertNotNil(reverseConversion);
        XCTAssertEqual(value, reverseConversion)
    }

    func test_toDate_With_Valid_Format_CentralTimeZone_Returns_ConvertedDate()
    {
        //ARRANGE
        let value = "12-25-2018 13:15";

        //ACT
        let result = try! value.toDate(dateFormat: DateFormats.Format_MM_dd_yyyy_With_HH_mm, expectedTimeZone: TimeZone(identifier: "CST"))

        let reverseConversion = result.toString(dateFormat: DateFormats.Format_MM_dd_yyyy_With_HH_mm, expectedTimeZone: TimeZone(identifier: "CST"))

        //ASSERT
        XCTAssertNotNil(result);
        XCTAssertNotNil(reverseConversion);
        XCTAssertEqual(value, reverseConversion) // this is done to match the pattern of the date being converted based on the format being passed
    }

    func test_toDate_With_Valid_Format2_Returns_ConvertedDate()
    {
        //ARRANGE
        let value = "12-25-2018 13:15";
        let format = DateFormats.Format_MM_dd_yyyy_With_HH_mm

        //ACT
        let result = try! value.toDate(dateFormat: format, expectedTimeZone: nil)

        let reverseConversion = result.toString(dateFormat: format, expectedTimeZone: nil)

        //ASSERT
        XCTAssertNotNil(result);
        XCTAssertNotNil(reverseConversion);
        XCTAssertEqual(value, reverseConversion) // this is done to match the pattern of the date being converted based on the format being passed
    }

    func test_toDate_With_InValid_Format_Throws_Exception()
    {
        //ARRANGE
        let value = "2018-3#-1@";

        //ASSERT
        XCTAssertThrowsError(try value.toDate(dateFormat: DateFormats.Format_yyyy_MM_dd, expectedTimeZone: nil)) { error in
            guard case StringExtensionException.invalidFormat(let value) = error else {
                return XCTFail("Different exception occured other than invalidFormat")
            }
            XCTAssertEqual(value, "Invalid DateFormat");
        }
    }

    func test_toDate_With_Nil_Formats_AndTimeZone_Returns_ValidDate()
    {
        //ARRANGE
        let value = Date().toString(dateFormat: nil, expectedTimeZone: nil)

        //ACT
        let result = try! value.toDate(dateFormat: nil, expectedTimeZone: nil);

        //ASSERT
        XCTAssertNotNil(result);
    }

    func test_toDate_WithTimeZone_Returns_Date_With_SpecifiedTimeZone()
    {
        //ARRANGE
        let value = "11-11-2018 17:35"
        let format = DateFormats.Format_MM_dd_yyyy_With_HH_mm

        //ACT
        let result = try! value.toDate(dateFormat: format, expectedTimeZone: TimeZone(identifier: "CST"));

        //ASSERT
        XCTAssertNotNil(result);
    }

    //MARK: convert to base64 test

    func test_convertToBase64_WithValidString_ReturnsBase64String(){

        //ARRANGE
        let value = "i am ios developer"

        //ACT
        let result = value.convertToBase64()

        //ASSERT
        XCTAssertNotNil(result)
        XCTAssertTrue(result == "aSBhbSBpb3MgZGV2ZWxvcGVy")
    }

    func test_convertToBase64_WithEmptyString_ReturnsEmptyString(){

        //ARRANGE
        let value = ""

        //ACT
        let result = value.convertToBase64()

        //ASSERT
        XCTAssertNotNil(result)
        XCTAssertTrue(result?.count == 0)
        XCTAssertTrue(result == String())
    }

    func test_convertToBase64_WithStringWithSpecialCharacter_ReturnsBase64String(){

        //ARRANGE
        let value = "He!10 W)rLd $%^&*"

        //ACT
        let result = value.convertToBase64()

        //ASSERT
        XCTAssertNotNil(result)
        XCTAssertTrue(result == "SGUhMTAgVylyTGQgJCVeJio=")
    }

    //MARK: Decode string tests

    func test_decodeFromBase64_WithValidString_ReturnsBase64String(){

        //ARRANGE
        let value = "SSBhbSBpb3MgcHJvZ3JhbW1lcg=="

        //ACT
        let result = value.decodeBase64()

        //ASSERT
        XCTAssertNotNil(result)
        XCTAssertTrue(result == "I am ios programmer")
    }

    func test_decodeFromBase64_WithStringWithSpecialCharacter_ReturnsBase64String(){

        //ARRANGE
        let value = "KiNeJCMoKiQmQCMoIGhlbGxvIHRoaXMgaXMgYW4gYW1hemluZyBzdHJpbmc="

        //ACT
        let result = value.decodeBase64()

        //ASSERT
        XCTAssertNotNil(result)
        XCTAssertTrue(result == "*#^$#(*$&@#( hello this is an amazing string")
    }

}
