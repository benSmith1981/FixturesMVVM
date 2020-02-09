//
//  MatchViewModel.swift
//  Fixtures
//
//  Created by Ben Smith on 30/01/2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation
protocol ViewModel {
//    var validationError: [ValidationError] { get set}
//    var isValid: Bool { mutating get}
}

class MatchViewModel {
    var matchModels: [MatchModel] = [MatchModel]()
    
    func getMatches(onCompletion: @escaping ([MatchModel], Bool) -> Void) {
        let dataService = DataAccess.init()
        dataService.fetchMatches { (matches) in
            self.matchModels = matches?.compactMap({ result in
                return MatchModel.init(homeTeam: result.homeTeam.name,
                                       awayTeam: result.awayTeam.name,
                                       awayTeamScore: result.score.fullTime.awayTeam ?? 0,
                                       homeTeamScore: result.score.fullTime.homeTeam ?? 0,
                                       matchDate: NSDate.dateWithISO8601String(dateString: result.utcDate!) ?? NSDate())
            }) ?? []
            
            DispatchQueue.main.async {
                onCompletion(self.matchModels, true)
            }
        }

    }

}

class MatchModel {
    var homeTeam: String?
    var awayTeam: String?
    var awayTeamScore: Int?
    var homeTeamScore: Int?
    var matchDate: NSDate?

    init(homeTeam: String, awayTeam: String, awayTeamScore: Int, homeTeamScore: Int, matchDate: NSDate) {
        self.awayTeam = awayTeam
        self.homeTeam = homeTeam
        self.awayTeamScore = awayTeamScore
        self.homeTeamScore = homeTeamScore
        self.matchDate = matchDate
    }
}
