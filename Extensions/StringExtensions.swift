//
//  StringExtensions.swift
//  Crabby
//
//  Created by CodeCat15 on 4/7/20.
//  Copyright © 2020 Crabby. All rights reserved.
//

import Foundation

enum StringExtensionException : Error, Equatable
{
    case invalidFormat(message:String)
}

public extension String
{
    /// Determines if the string passed is a valid email string
    ///
    /// - Returns: *True*: if the passed string is a valid email id, *False* if the passed string is invalid email id
    /// - sample code: stringObject.isValidEmail()
    func isValidEmail() -> Bool
    {
        let regex = try! NSRegularExpression(pattern: "(^[0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,64}$)", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }

    /// Converts the given string into a URL
    ///
    /// - Returns: converted URL object of the string
    /// - Throws: If an invalid string is provided for conversion to URL it throws StringExtensionException.invalidFormat exception
    /// - sample code: "https://www.apple.com".toURL()
    func toURL() throws -> URL
    {
        guard let result = URL(string: self) else {
            throw StringExtensionException.invalidFormat(message: "string provided for conversion to URL is not a valid string")
        }
        return result;
    }

    /// Converts a string object to a valid DateTime object
    ///
    /// - Parameters:
    ///   - dateFormat: A date format which you would like date to be converted, default format is MM-DD-YYYY HH:mm:ss
    ///   - expectedTimeZone: A timezone in which you want your converted date string to be, default timezone is TimeZone.current
    /// - Returns: Returns a non-optional Date value from given string object.

    /// - sample code 1: stringObject.toDate(dateFormat: DateFormats.Format_MM_dd_yyyy_With_HH_mm_ss, expectedTimeZone: TimeZone(identifier: "UTC"));

    /// - sample code 2: stringObject.toDate(dateFormat: nil, expectedTimeZone: nil);
    /// - Throws: If an invalid date format is provided for conversion to Date it throws StringExtensionException.invalidFormat exception
    func toDate(dateFormat: String? , expectedTimeZone: TimeZone?) throws -> Date
    {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = dateFormat != nil ? dateFormat! : DateFormats.Format_MM_dd_yyyy_With_HH_mm_ss;
        dateFormatter.timeZone = expectedTimeZone == nil ? TimeZone.current : expectedTimeZone!;

        guard let result = dateFormatter.date(from: self)
            else{
                throw StringExtensionException.invalidFormat(message: "Invalid DateFormat")
        }

        return result
    }

    ///converts the string representation of date to a UTC datetime format
    func toDate(dateFormat: String) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        formatter.dateFormat = dateFormat
        return formatter.date(from: self)
    }

    /// Converts the string into a base64 representation
    func convertToBase64() -> String? {
        guard let data = self.data(using: .utf8) else{
            return nil
        }
        return data.base64EncodedString()
    }

    /// Decodes a base64 string and returns string representation for the same
    func decodeBase64() -> String? {
        guard let data = Data(base64Encoded: self) else{
            return nil
        }
        return String(data: data, encoding: .utf8)
    }

    /// Verifies if the given string contains number
    func containsNumber() -> Bool{
        let numbersRange = self.rangeOfCharacter(from: .decimalDigits)
        return numbersRange != nil
    }
}
