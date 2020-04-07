//
//  DateExtensions.swift
//  Crabby
//
//  Created by CodeCat15 on 4/7/20.
//  Copyright © 2020 Crabby. All rights reserved.
//

import Foundation

 struct DateFormats
{
    static let Format_yyyy_MM_dd = "yyyy-MM-dd"
    static let Format_MM_dd_yyyy_With_HH_mm = "MM-dd-yyyy HH:mm"
    static let Format_MM_dd_yyyy_With_HH_mm_ss = "MM-dd-yyyy HH:mm:ss"
    static let Format_yyyy_MM_dd_TimeZone = "yyyy-MM-dd'T'HH:mm:ssZZZ"
    static let Format_MMM_d_yyyy = "MMM d, yyyy"
}

public extension Date
{
    /// Convert a date object to a non optional string, you can pass the parameter or keep it nil, if you keep the parameter nil, this method uses it's default values to perform the conversion
    ///
    /// - Parameters:
    ///   - dateFormat: A date format which you would like date to be converted, default format is MM-DD-YYYY HH:mm:ss
    ///   - expectedTimeZone: A timezone in which you want your converted date string to be, default timezone is TimeZone.current
    /// - Returns: Returns a non-optional string value from given date.

    /// - sample code 1: dateObject.toString(dateFormat: DateFormats.Format_MM_dd_yyyy_With_HH_mm_ss, expectedTimeZone: TimeZone(identifier: "UTC"));

    /// - sample code 2: dateObject.toString(dateFormat: nil, expectedTimeZone: nil);
    func toString(dateFormat: String? , expectedTimeZone: TimeZone?) -> String
    {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = dateFormat != nil ? dateFormat! : DateFormats.Format_MM_dd_yyyy_With_HH_mm_ss;
        dateFormatter.timeZone = expectedTimeZone == nil ? TimeZone.current : expectedTimeZone!;
        return dateFormatter.string(from: self);
    }

    /// Adds days to current date
    /// Parameter:
    /// - daysToAdd: An integer value indicating the number of days you want to add to the current date
    func addDaysToDate(daysToAdd: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: daysToAdd, to: self)
    }
}
