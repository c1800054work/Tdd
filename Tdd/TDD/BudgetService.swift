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

    func getEndPeriodInMonthRatio(endDate: String, yearMonth: String) -> Double {

        let endDateCompnent = endDate.toDate(with: "yyyyMMdd")?.get(.day, .month, .year)
        guard let end = endDateCompnent?.day else {
            return 0
        }

        ///這個月有幾天
        guard let currentMonthDay = yearMonth.toDate(with: "yyyyMM")?.getDaysInMonth() else {
            return 0
        }
        
        return Double(end) / Double(currentMonthDay)
    }
    
    func getStartPeriodInMonthRatio(startDate: String, yearMonth: String) -> Double {

        let startDateCompnent = startDate.toDate(with: "yyyyMMdd")?.get(.day, .month, .year)

        guard let start = startDateCompnent?.day else {
            return 0
        }

        ///這個月有幾天
        guard let currentMonthDay = yearMonth.toDate(with: "yyyyMM")?.getDaysInMonth() else {
            return 0
        }
        return Double(currentMonthDay - start + 1 ) / Double(currentMonthDay)
    }

    
    func getSameYearMonthPeriodInMonthRatio(startDate: String, endDate: String, yearMonth: String) -> Double {

        let startDateCompnent = startDate.toDate(with: "yyyyMMdd")?.get(.day, .month, .year)
        let endDateCompnent = endDate.toDate(with: "yyyyMMdd")?.get(.day, .month, .year)

        guard let start = startDateCompnent?.day else {
            return 0
        }
        
        guard let end = endDateCompnent?.day else {
            return 0
        }

        ///這個月有幾天
        guard let currentMonthDay = yearMonth.toDate(with: "yyyyMM")?.getDaysInMonth() else {
            return 0
        }
        return Double(end - start + 1 ) / Double(currentMonthDay)
    }

    func getBudget(startDate _startDate: String, endDate _endDate: String) -> Double {
        let budgets = budgetRepo?.getAll().filter {
            let startDate = _startDate.toDate(with: "yyyyMMdd")?.date2String(dateFormat: "yyyyMM") ?? "0"
            let endDate = _endDate.toDate(with: "yyyyMMdd")?.date2String(dateFormat: "yyyyMM") ?? "0"
            return $0.date.asInt() >= startDate.asInt() && $0.date.asInt() <= endDate.asInt()
        } ?? []
        var totalBudget: Double = 0.0
        budgets.forEach {
            let yyyyMMddOfStartDate = _startDate.toDate(with: "yyyyMMdd")?.date2String(dateFormat: "yyyyMM")
            let yyyyMMddOfEndDate = _endDate.toDate(with: "yyyyMMdd")?.date2String(dateFormat: "yyyyMM")
            if yyyyMMddOfStartDate == yyyyMMddOfEndDate {
                totalBudget += Double($0.budget) * getSameYearMonthPeriodInMonthRatio(startDate: _startDate,endDate: _endDate, yearMonth: $0.date)
            }
            else if _startDate.toDate(with: "yyyyMMdd")?.date2String(dateFormat: "yyyyMM") == $0.date {
                totalBudget += Double($0.budget) * getStartPeriodInMonthRatio(startDate: _startDate, yearMonth: $0.date)
            }
            else if _endDate.toDate(with: "yyyyMMdd")?.date2String(dateFormat: "yyyyMM") == $0.date {
                totalBudget += Double($0.budget) * getEndPeriodInMonthRatio(endDate: _endDate, yearMonth: $0.date)
            } else {
                totalBudget += Double($0.budget)
            }
        }
        return totalBudget
    }
}
