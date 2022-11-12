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

    func getYYYYMM(_ date: String) -> Date? {
        date.toDate(with: "yyyyMM")
    }
    // 取得當月總共有幾天
    func getDayInMonth(_ date: String) -> Int {
        date.toDate(with: "yyyyMMdd")?.getDaysInMonth() ?? 0
    }

    func getBudgetInMonth(_ date: String) -> Int {
        guard let date = date.toDate(with: "yyyyMMdd") else {
            return 0
        }
        return  budgetRepo?.getAll().first {
                    $0.date == date.date2String(dateFormat: "yyyyMM")
                }?.budget ?? 0
    }

    func getStartPeriodInMonthRatio(date: String, yearMonth: String) -> Double {

        if date.toDate(with: "yyyyMM")?.date2String(dateFormat: "yyyyMM") != yearMonth {
            return 0
        }

        guard let day = date.toDate(with: "yyyyMMdd")?.get(.day, .month, .year).day else {
            return 0
        }

        let components = yearMonth.toDate(with: "yyyyMM")?.get(.day, .month, .year)
        ///這個月有幾天
        guard let currentMonthDay = components?.day else {
            return 0
        }
        return Double(currentMonthDay - day + 1) / Double(currentMonthDay)
    }

    func getPEnderiodInMonthRatio(date: String, yearMonth: String) -> Double {

        if date.toDate(with: "yyyyMM")?.date2String(dateFormat: "yyyyMM") != yearMonth {
            return 0
        }

        guard let day = date.toDate(with: "yyyyMMdd")?.get(.day, .month, .year).day else {
            return 0
        }

        let components = yearMonth.toDate(with: "yyyyMM")?.get(.day, .month, .year)
        ///這個月有幾天
        guard let currentMonthDay = components?.day else {
            return 0
        }
        return Double(currentMonthDay - day + 1) / Double(currentMonthDay)
    }

    func getBudget(startDate _startDate: String, endDate _endDate: String) -> Double {
        let startDate = _startDate.toDate(with: "yyyyMMdd")?.date2String(dateFormat: "yyyyMM") ?? "0"
        let endDate = _endDate.toDate(with: "yyyyMMdd")?.date2String(dateFormat: "yyyyMM") ?? "0"
        let budgets = budgetRepo?.getAll().filter {
            $0.date.asInt() >= startDate.asInt() && $0.date.asInt() <= endDate.asInt()
        } ?? []
        var totalBudget: Double = 0.0
        budgets.forEach {
            if _startDate.toDate(with: "yyyyMM")?.date2String(dateFormat: "yyyyMM") != $0.date &&
                _endDate.toDate(with: "yyyyMM")?.date2String(dateFormat: "yyyyMM") != $0.date {
                totalBudget += Double($0.budget)
            } else if _startDate.toDate(with: "yyyyMM") == _endDate.toDate(with: "yyyyMM")  {
                totalBudget += Double($0.budget) * getPeriodInMonthRatio(date: _endDate, yearMonth: $0.date)
            }
            else {
                totalBudget += Double($0.budget) * getPeriodInMonthRatio(date: _endDate, yearMonth: $0.date)
                totalBudget += Double($0.budget) * getPeriodInMonthRatio(date: _startDate, yearMonth: $0.date)
            }
        }
        return totalBudget
    }
}
