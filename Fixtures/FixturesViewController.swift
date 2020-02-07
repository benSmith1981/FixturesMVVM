import UIKit
import Alamofire

class FixturesViewController: UITableViewController {

    private var matchViewModels: MatchViewModel?
    var matchModels: [MatchModel] = [MatchModel]()

    private var dataSource: TableViewDataSource<UITableViewCell, MatchModel>! //SourceViewModel rep each data in the cell we want to display
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MatchViewModel.init().getMatches { (matchModels, success) in
            if success {
                self.matchModels = matchModels
                self.dataSource = TableViewDataSource.init(cellIdentifier: "fixture",
                                                           items: self.matchModels,
                                                           configureCell: { (cell, viewModel) in
                                                            let fixtureCell = cell as! FixtureTableViewCell
                                                            fixtureCell.homeTeamNameLabel.text = viewModel.homeTeam
                                                            fixtureCell.awayTeamNameLabel.text = viewModel.awayTeam
                })
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
            }
        }

        

    }
}

class FixtureTableViewCell: UITableViewCell {

    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
}
