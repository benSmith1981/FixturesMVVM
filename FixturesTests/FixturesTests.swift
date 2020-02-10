//
//  FixturesTests.swift
//  FixturesTests
//
//  Created by Ben Smith on 10/02/2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import XCTest
@testable import Fixtures

class FixturesTests: XCTestCase {
    var fixturesVC: FixturesViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: FixturesViewController = storyboard.instantiateViewController(withIdentifier: "FixturesViewController") as! FixturesViewController
        fixturesVC = vc
        _ = fixturesVC.view // To call viewDidLoad
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataLayerWithInvalidURL() {
        // other setup
        let exp = expectation(description: "Check we get some data")
        var error: UrlConnectionError!
        var matches: [Match] = []
        
        DataAccess(baseURL: "www..xdfsd.com").fetchMatches { (response, errorMessage) in
            exp.fulfill()
            error = errorMessage
            matches = response?.matches ?? []
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertTrue(matches.isEmpty)
            XCTAssert(error == nil, "\(error?.localizedDescription ?? "")")
            
        }
    }
    
    func testTableViewDelegateSetupProperly() {
        let model2 = MatchModel.init(competition: "test", homeTeam: "", awayTeam: "", awayTeamScore: 0, homeTeamScore: 0, matchDate: Date(), status: .FINISHED)
        
        let datasource = TableViewDataSource.init(cellIdentifier: "fixture", items: [model2], configureCell: { (cell, item, indexPath) in
            print(item.competition)
        })
        let delegate = TableViewDelegate.init(headerCellIdentifier: "MatchHeaderTableViewCell", items: [model2]) { (cell, items, section) in
        }
        self.fixturesVC.tableView.dataSource = datasource
        self.fixturesVC.tableView.delegate = delegate
        fixturesVC.tableView.reloadData()

        XCTAssertNotNil( self.fixturesVC.tableView.delegate, "Have a header")
        
    }
    
    func testTableViewDatasourceSetupProperlyWith2Sections() {
        let model1 = MatchModel.init(competition: "test", homeTeam: "", awayTeam: "", awayTeamScore: 0, homeTeamScore: 0, matchDate: Date(), status: .FINISHED)
        let model2 = MatchModel.init(competition: "test", homeTeam: "", awayTeam: "", awayTeamScore: 0, homeTeamScore: 0, matchDate: Date(), status: .FINISHED)
        
        let datasource = TableViewDataSource.init(cellIdentifier: "fixture", items: [model1,model2], configureCell: { (cell, item, indexPath) in
            print(item.competition)
        })
        
        fixturesVC.tableView.dataSource = datasource
        fixturesVC.tableView.reloadData()
        XCTAssert(fixturesVC.tableView.numberOfSections == 2)

        
    }
        
    func testTableViewDatasourceSetupProperlyWith1rows() {

        let models = MatchModel.init(competition: "test", homeTeam: "", awayTeam: "", awayTeamScore: 0, homeTeamScore: 0, matchDate: Date(), status: .FINISHED)

        let datasource = TableViewDataSource.init(cellIdentifier: "fixture", items: [models], configureCell: { (cell, item, indexPath) in
            print(item.competition)
        })
        fixturesVC.tableView.dataSource = datasource
        fixturesVC.tableView.reloadData()
        XCTAssert(fixturesVC.tableView.numberOfSections == 1)
    }
    
    func getTestData() {
        let exp = expectation(description: "Check we get some data")
        let connectionService = DataAccess.init()
        connectionService.fetchMatches { (response, connection) in
            exp.fulfill()
        }
    }
    
    func testWeGetData() {
        // other setup
        getTestData()
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertTrue(self.fixturesVC.matchModels.count > 0)
        }
    }
    
    func testSortingScheduledResults() {
        let exp = expectation(description: "Check we test data correctly")

        var scheduled: [MatchModel] = []
        var finished: [MatchModel] = []

        DataAccess.init().fetchFromStaticJSON(resourceName: "testFixtures") { (response, connectionError) in
            exp.fulfill()
            var matchModels = response?.matches.compactMap({ result in
                return MatchModel.init(competition: response?.competition.name ?? "",
                                       homeTeam: result.homeTeam.name,
                                       awayTeam: result.awayTeam.name,
                                       awayTeamScore: result.score.fullTime.awayTeam ?? -1,
                                       homeTeamScore: result.score.fullTime.homeTeam ?? -1,
                                       matchDate: result.utcDate.dateWithISO8601String() ?? Date(),
                                       status: matchStatus.status(status: result.status ?? ""))
            }) ?? []
            
            scheduled = MatchViewModel.init().sortScheduledMatches(matchModels: matchModels)
            finished = MatchViewModel.init().sortFinishedMatches(matchModels: matchModels)
        }
        waitForExpectations(timeout: 10) { error in
            XCTAssertTrue(scheduled.count == 1)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
