//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

extension String {

    enum Compare: String {
        /// >=
        case greater_equal
        /// >
        case greater
        /// =
        case equal
        /// <=
        case less_equal
        /// <
        case less
    }


    /// 字符串 -> 日期
    func toDate(with format:String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_TW")
        formatter.timeZone = NSTimeZone(abbreviation: "HKT") as TimeZone?
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .iso8601)
        let date = formatter.date(from: self)
        return date
    }

    /// 字符串 -> 日期
    func toDate(from oldFormat:String, to newFormat:String) -> String? {
        toDate(with: oldFormat)?.date2String(dateFormat: newFormat)
    }

    func asInt() -> Int{
        Int(self) ?? 0
    }

    /// /是否非數字
    func cbkIsNaN() -> Bool {
        asDouble() == nil || self == "-"
    }

    func asDouble() -> Double?{
        Double(self)?.avoidNotation()
    }

    /// 數值比較
    func n_compare(type: Compare, val:String?) -> Bool {

        guard let val = val else { return false}

        if cbkIsNaN() { return false }

        switch type {
        case .greater_equal:
            return n_compare(type: .greater, val: val) || n_compare(type: .equal, val: val)
        case .greater:
            return NSDecimalNumber(string: self).compare(NSDecimalNumber(string: val)) == .orderedDescending
        case .equal:
            return NSDecimalNumber(string: self).compare(NSDecimalNumber(string: val)) == .orderedSame
        case .less:
            return NSDecimalNumber(string: self).compare(NSDecimalNumber(string: val)) == .orderedAscending
        case .less_equal:
            return n_compare(type: .less, val: val) || n_compare(type: .equal, val: val)
        }
    }
}