//
// Created by kaiyu_chang on 2022/11/12.
//

import Foundation

class Tennis {

    var player1: TennisPlayer
    var player2: TennisPlayer
    var scoreOfPlayer1: Int = 0
    var scoreOfPlayer2: Int = 0

    init(player1: String, player2: String) {
        self.player1 = TennisPlayer(name: player1)
        self.player2 = TennisPlayer(name: player2)
    }

    func getScore() -> String {
        isSameScore() ? isDeuce() ? "deuce" : getSameScore() :
        isReadyForGamePoint() ?  getAdvantage() : getLookupScore()
    }

    private func getSameScore() -> String {
        "\(Score.allCases[scoreOfPlayer1].rawValue) all"
    }

    private func isSameScore() -> Bool {
        scoreOfPlayer1 == scoreOfPlayer2
    }

    private func isDeuce() -> Bool {
        scoreOfPlayer1 >= 3 && isSameScore()
    }

    private func isReadyForGamePoint() -> Bool {
        scoreOfPlayer1 > 3 || scoreOfPlayer2 > 3
    }

    private func getLookupScore() -> String {
        "\(Score.allCases[scoreOfPlayer1].rawValue)-\(Score.allCases[scoreOfPlayer2].rawValue)"
    }

    private func getAdvantage() -> String {
        abs(scoreOfPlayer1 - scoreOfPlayer2) == 1 ?
                "\(scoreOfPlayer1 > scoreOfPlayer2 ? player1.name : player2.name) adv" :
                "\(scoreOfPlayer1 > scoreOfPlayer2 ? player1.name : player2.name) win"
    }

    func player1Score() {
        scoreOfPlayer1 += 1
    }

    func player2Score() {
        scoreOfPlayer2 += 1
    }
}