//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

class BudgetService {

    private var budgetRepo: IBudgetReport?

    func setBudgetData(_ repo: IBudgetReport) {
        budgetRepo = repo
    }

    func getBudget(startDate: Date?, endDate: Date?) -> Double {
        budgetRepo?.getAll().reduce(0) { result, budget in
            result + budget.getOverlayBudget(startDate: startDate, endDate: endDate)
        } ?? 0
    }
}
