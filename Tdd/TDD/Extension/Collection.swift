//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

extension Collection {

    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

