//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

public extension Double {

    func avoidNotation(fractionDigits: Int = 100) -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.maximumFractionDigits = fractionDigits
        numberFormatter.numberStyle = .decimal
        guard let number = numberFormatter.string(for: self) else {return nil}
        return numberFormatter.number(from: number)?.doubleValue
    }

    func equals(_ other: Double, precised precisedValue: Int = 1) -> Bool {
        precised(precisedValue) == other.precised(precisedValue)
    }

    func precised(_ value: Int = 1) -> Double {
        let offset = pow(10, Double(value))
        return (self * offset).rounded() / offset
    }
}
