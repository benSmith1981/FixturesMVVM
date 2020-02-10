//
//  FixtureTableViewCell.swift
//  Fixtures
//
//  Created by Ben Smith on 10/02/2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation
import UIKit
class FixtureTableViewCell: UITableViewCell {
    @IBOutlet weak var scheduledStackView: UIStackView!
    @IBOutlet weak var resultsStackView: UIStackView!

    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var countDown: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var stadium: UILabel!
    @IBOutlet weak var scoreHome: UILabel!
    @IBOutlet weak var scoreAway: UILabel!
    
}
