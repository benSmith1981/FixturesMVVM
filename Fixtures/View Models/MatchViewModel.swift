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
        dataService.fetchFromStaticJSON{ (response) in
            self.matchModels = response?.matches.compactMap({ result in
                return MatchModel.init(competition: response?.competition.name ?? "",
                                       homeTeam: result.homeTeam.name,
                                       awayTeam: result.awayTeam.name,
                                       awayTeamScore: result.score.fullTime.awayTeam ?? -1,
                                       homeTeamScore: result.score.fullTime.homeTeam ?? -1,
                                       matchDate: result.utcDate.dateWithISO8601String() ?? Date(),
                                       status: matchStatus.status(status: result.status ?? ""))
            }) ?? []
            
            let scheduled = self.sortScheduledMatches(matchModels: self.matchModels)
            let finished = self.sortFinishedMatches(matchModels: self.matchModels)
            DispatchQueue.main.async {
                onCompletion( finished + scheduled, true)
            }
        }

    }
    
    func sortScheduledMatches(matchModels: [MatchModel]) -> [MatchModel] {
        return matchModels
            .filter { $0.status == matchStatus.SCHEDULED }
            .sorted { $0.matchDate.compare($1.matchDate as Date) == .orderedDescending }
    }
    
    func sortFinishedMatches(matchModels: [MatchModel]) -> [MatchModel] {
        return matchModels
            .filter { $0.status == matchStatus.FINISHED }
            .sorted { $0.matchDate.compare($1.matchDate as Date) == .orderedDescending }
    }

}

enum matchStatus: String {
    case FINISHED
    case SCHEDULED
    case unknown
    
    static func status(status: String) -> matchStatus {
        switch status {
        case "FINISHED":
            return .FINISHED
        case "SCHEDULED":
            return .SCHEDULED
        default:
            return .unknown
        }
    }
}

class MatchModel {
    var competition: String?
    var homeTeam: String?
    var awayTeam: String?
    var awayTeamScore: Int?
    var homeTeamScore: Int?
    var status: matchStatus?
    var matchDate: Date

    init(competition: String, homeTeam: String, awayTeam: String, awayTeamScore: Int, homeTeamScore: Int, matchDate: Date, status: matchStatus) {
        self.competition = competition
        self.awayTeam = awayTeam
        self.homeTeam = homeTeam
        self.awayTeamScore = awayTeamScore
        self.homeTeamScore = homeTeamScore
        self.matchDate = matchDate
        self.status = status
    }
}
