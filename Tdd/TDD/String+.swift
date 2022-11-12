//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

extension String {
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
}