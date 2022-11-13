//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

extension Date {

    func getDaysInMonth() -> Int{
        let calendar = Calendar.current

        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count

        return numDays
    }

    ///日期 -> 字符串
    func date2String(dateFormat:String = "yyyy/MM/dd") -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = NSTimeZone(abbreviation: "HKT") as TimeZone?;
        formatter.locale = Locale.init(identifier: "zh_TW")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: self)
        return date
    }

    func getDate(with dateFormat: String) -> Date? {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = NSTimeZone(abbreviation: "HKT") as TimeZone?;
        formatter.locale = Locale.init(identifier: "zh_TW")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: date2String(dateFormat: dateFormat))
        return date
    }

    func getLastDayOfDate() -> Date? {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        guard let date = calendar.date(from: dateComponents) else {return nil}
        guard let range = calendar.range(of: .day, in: .month, for: date) else {return nil}
        let numDays = range.count
        return calendar.date(byAdding: .day, value: numDays - 1, to: date)
    }

    func getFirstDayOfDate() -> Date? {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self), day: 1)
        return calendar.date(from: dateComponents)
    }
}
