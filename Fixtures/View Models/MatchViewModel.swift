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
        dataService.fetchFromStaticJSON { (matches) in
            self.matchModels = matches?.compactMap({ result in
                return MatchModel.init(homeTeam: result.homeTeam.name, awayTeam: result.awayTeam.name)
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

    init(homeTeam: String, awayTeam: String) {
        self.awayTeam = awayTeam
        self.homeTeam = homeTeam

    }
}
