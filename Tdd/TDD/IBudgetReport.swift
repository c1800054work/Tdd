//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

struct Budget {
    ///YYYYMM
    var date: String
    var amt: Int

    func getDate() -> Date? {
        date.toDate(with: "yyyyMM")
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
