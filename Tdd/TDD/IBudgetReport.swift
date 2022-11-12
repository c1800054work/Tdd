//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

struct Budget {
    ///YYYYMM
    var date: String
    var budget: Int
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