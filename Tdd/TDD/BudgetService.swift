//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

class BudgetService {

    private var startDate: Date?
    private var endData: Date?
    private var budgetRepo: IBudgetReport?

    func setBudgetData(_ repo: IBudgetReport) {
        budgetRepo = repo
    }

    func getEndPeriodInMonthRatio(endDate: String) -> Double {

        guard let endDate = endDate.toDate(with: "yyyyMMdd") else {
            return 0
        }
        guard let end = endDate.get(.day, .month, .year).day else {
            return 0
        }
        return Double(end) / Double( endDate.getDaysInMonth())
    }
    
    func getStartPeriodInMonthRatio(startDate: String) -> Double {

        guard let startDate = startDate.toDate(with: "yyyyMMdd") else {
            return 0
        }

        guard let start = startDate.get(.day, .month, .year).day else {
            return 0
        }
        let currentMonthDay = startDate.getDaysInMonth()
        return Double(currentMonthDay - start + 1 ) / Double(currentMonthDay)
    }

    
    func getSameYearMonthPeriodInMonthRatio(startDate: String, endDate: String, yearMonth: String) -> Double {

        guard let startDate = startDate.toDate(with: "yyyyMMdd") else {
            return 0
        }
        guard let endDate = endDate.toDate(with: "yyyyMMdd") else {
            return 0
        }
        guard let start = startDate.get(.day, .month, .year).day else {
            return 0
        }
        guard let end = endDate.get(.day, .month, .year).day  else {
            return 0
        }

        return Double(end - start + 1 ) / Double(startDate.getDaysInMonth())
    }

    func getBudget(startDate _startDate: String, endDate _endDate: String) -> Double {
        guard let startDateOfYearMonth = _startDate.toDate(from: "yyyyMMdd", to: "yyyyMM"),
              let endDateOfYearMonth = _endDate.toDate(from: "yyyyMMdd", to: "yyyyMM") else {
            return 0
        }
        let budgets = budgetRepo?.getAll().filter {
            $0.date.asInt() >= startDateOfYearMonth.asInt() && $0.date.asInt() <= endDateOfYearMonth.asInt()
        } ?? []
        var totalBudget: Double = 0.0
        budgets.forEach {
            if startDateOfYearMonth == endDateOfYearMonth {
                totalBudget += Double($0.budget) * getSameYearMonthPeriodInMonthRatio(startDate: _startDate,endDate: _endDate, yearMonth: $0.date)
            }
            else if startDateOfYearMonth == $0.date {
                totalBudget += Double($0.budget) * getStartPeriodInMonthRatio(startDate: _startDate)
            }
            else if endDateOfYearMonth == $0.date {
                totalBudget += Double($0.budget) * getEndPeriodInMonthRatio(endDate: _endDate)
            } else {
                totalBudget += Double($0.budget)
            }
        }
        return totalBudget
    }
}
