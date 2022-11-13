//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

struct Budget {
    ///YYYYMM
    var date: String
    var amt: Int

    func getDateOfYearMonth() -> Date? {
        date.toDate(with: "yyyyMM")
    }

    func getDailyBudget() -> Double {
        guard let date = getDateOfYearMonth() else {
            return 0
        }
        return amt.double / date.getDaysInMonth().double
    }

    func getOverlayBudget(startDate: Date?, endDate: Date?) -> Double {
        guard let date = getDateOfYearMonth() else{
            return 0
        }
        guard let startDate = startDate, let endDate = endDate, startDate <= endDate else {
            return 0
        }
        guard let firstDayOfMonth = date.getFirstDayOfDate(),
              let lastDayOfMonth = date.getLastDayOfDate() else {
            return 0
        }
        guard startDate <= lastDayOfMonth && endDate >= firstDayOfMonth else {
            return 0
        }
        let start = startDate > firstDayOfMonth ? startDate : firstDayOfMonth
        let end = endDate < lastDayOfMonth ? endDate : lastDayOfMonth
        return getDailyBudget() * getDaysDiff(from: start, to: end).double
    }

    private func getDaysDiff(from: Date?, to: Date?) -> Int {
        guard let from = from, let to = to else {
            return 0
        }
        guard let days = Calendar.current.dateComponents([.day], from: from, to: to).day else {
            return 0
        }
        return days+1
    }
}

struct IBudgetReport {
    var m_aryData: [Budget]
    init(m_aryData: [Budget]) {
        self.m_aryData = m_aryData
    }
    func getAll() ->  [Budget] {
        m_aryData
    }
}
