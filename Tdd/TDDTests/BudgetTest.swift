//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

import XCTest
@testable import TDD

class BudgetTest: XCTestCase {

    private let budgetService = BudgetService()

    override func setUp() {
        super.setUp()
    }

    func test_整月() {
        let data1 = Budget(date:"202209", budget: 3000)
        let data2 = Budget(date:"202210", budget: 310)
        let data3 = Budget(date:"202211", budget: 300)

        let repo = IBudgetReport(m_aryData: [data1, data2, data3])
        budgetService.setBudgetData(repo)

        let result = budgetService.getBudget(startDate: "20221001", endDate: "20221031")
        XCTAssertEqual(310.0, result)
    }

    func test_一天() {
        let data1 = Budget(date: "202002", budget: 2900)
        let data2 = Budget(date: "202208", budget: 310)
        let data3 = Budget(date: "202205", budget: 600)
        let data4 = Budget(date: "202202", budget: 560)

        let repo = IBudgetReport(m_aryData: [data1, data2, data3, data4])
        budgetService.setBudgetData(repo)

        let result = budgetService.getBudget(startDate: "20220808", endDate: "20220808")
        XCTAssertEqual(10.0, result)
    }

    func test_跨月_不足月() {
        let data1 = Budget(date: "202209", budget: 300)
        let data2 = Budget(date: "202210", budget: 3100)
        let data3 = Budget(date: "202211", budget: 3000)

        let repo = IBudgetReport(m_aryData: [data1, data2, data3])
        budgetService.setBudgetData(repo)

        let result = budgetService.getBudget(startDate: "20220913", endDate: "20221126")
        //180+3100+2600
        XCTAssertEqual(5880.0, result)
    }

    func test_部份月() {
        let data1 = Budget(date: "202209", budget: 30)
        let data2 = Budget(date: "202210", budget: 3100)
        let data3 = Budget(date: "202211", budget: 300)

        let repo = IBudgetReport(m_aryData: [data1, data2, data3])
        budgetService.setBudgetData(repo)

        let result = budgetService.getBudget(startDate: "20221003", endDate: "20221020")
        XCTAssertEqual(1800, result)
    }

    func test_非法區間() {
        let data1 = Budget(date: "202204", budget: 1200)
        let data2 = Budget(date: "202202", budget: 28)
        let data3 = Budget(date: "202211", budget: 30)

        let repo = IBudgetReport(m_aryData: [data1, data2, data3])
        budgetService.setBudgetData(repo)

        let result = budgetService.getBudget(startDate: "20221003", endDate: "20221002")
        XCTAssertEqual(0.0, result)
    }
}
