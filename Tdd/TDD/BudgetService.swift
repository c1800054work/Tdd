//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

class BudgetService {

    private var budgetRepo: IBudgetReport?

    func setBudgetData(_ repo: IBudgetReport) {
        budgetRepo = repo
    }

    private func getMonthRatio(from: Date?, to: Date?) -> Double {
        guard let from = from, let to = to, from <= to else {
            return 0
        }
        guard let days = Calendar.current.dateComponents([.day], from: from, to: to).day else {
            return 0
        }
        return (days+1).double / from.getDaysInMonth().double
    }

    func getBudget(startDate: Date?, endDate: Date?) -> Double {
        guard let startDateOfYearMonth = startDate?.getDate(with: "yyyyMM"),
              let endDateOfYearMonth = endDate?.getDate(with: "yyyyMM") else {
            return 0
        }

        let budgets = budgetRepo?.getAll().filter {
            guard let date = $0.getDate() else {
                return false
            }
            return date >= startDateOfYearMonth && date <= endDateOfYearMonth
        } ?? []

        return budgets.reduce(0.0) {
            guard let date = $1.getDate() else {
                return $0
            }
            let amt = $1.amt.double
            var ratio = 1.0 //預設100%
            if startDateOfYearMonth == endDateOfYearMonth {
                ratio = getMonthRatio(from: startDate, to: endDate)
            } else if startDateOfYearMonth == date {
                ratio = getMonthRatio(from: startDate, to: startDate?.getLastDayOfDate())
            } else if endDateOfYearMonth == date {
                ratio = getMonthRatio(from: endDateOfYearMonth, to: endDate)
            }
            return $0 + amt * ratio
        }
    }
}
