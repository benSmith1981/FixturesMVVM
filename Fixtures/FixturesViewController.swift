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

                self.dataSource = TableViewDataSource.init(headerCellIdentifier: "MatchHeaderTableViewCell",
                                                           cellIdentifier: "fixture",
                                                           items: self.matchModels,
                                                           configureCell: { (cell, viewModel, indexPath) in
                                                            
                                                            let fixtureCell = cell as! FixtureTableViewCell
                                                            fixtureCell.homeTeamNameLabel.text = viewModel.homeTeam
                                                            fixtureCell.awayTeamNameLabel.text = viewModel.awayTeam
                                                            fixtureCell.time.text = viewModel.matchDate.getTime()
                                                            fixtureCell.countDown.text = viewModel.matchDate.getDate()
                                                            
                                                            let scoreAway = viewModel.awayTeamScore == -1 ? "" : "\(viewModel.awayTeamScore!)"
                                                            fixtureCell.scoreAway.text = scoreAway
                                                            
                                                            let scoreHome = viewModel.homeTeamScore == -1 ? "" : "\(viewModel.homeTeamScore!)"
                                                            fixtureCell.scoreHome.text = scoreHome
                                                            fixtureCell.stadium.text = viewModel.homeTeam
                                                            if viewModel.status == matchStatus.FINISHED {
                                                                cell.backgroundColor = UIColor.orange
                                                            }
                                                            self.tableView.headerView(forSection: indexPath.section)

                }, configureHeaderCell: { (headerCell, viewModel, section) in
                    let headerCell2 = headerCell as! MatchHeaderTableViewCell
                    headerCell2.dateLabel.text = viewModel.matchDate.getDate()
                    headerCell2.championshipLabel.text = viewModel.competition

                })
                let profileNib = UINib(nibName: "MatchHeaderTableViewCell", bundle: nil)
                self.tableView.register(profileNib, forCellReuseIdentifier: "MatchHeaderTableViewCell")
                self.tableView.dataSource = self.dataSource
                self.tableView.delegate = self.dataSource
                self.tableView.reloadData()
            }
        }
    }
    
}

class FixtureTableViewCell: UITableViewCell {

    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var countDown: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var stadium: UILabel!
    @IBOutlet weak var scoreHome: UILabel!
    @IBOutlet weak var scoreAway: UILabel!

}
