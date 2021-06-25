//
//  TournamentListVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 11/05/21.
//

import UIKit

class TournamentListVC: BaseVC {
    @IBOutlet weak var lblSelectedTab:UILabel!
    @IBOutlet weak var lblNonSelectedTab:UILabel!
    @IBOutlet weak var tableView:UITableView!
    
    var pastName = ""
    var upcomming = ""
    var isUpcoming = true
    var tournaments:[Tournaments] = []
    var runs:[Run] = []
    var arrCategories:[TournamentsType] = []
    var sports:[Sports] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pastName = isTournament ? "Past Tournaments" : "Past Runs"
        upcomming = isTournament ? "Upcomming Tournaments" : "Upcomming Runs"
        lblSelectedTab.text = upcomming
        lblNonSelectedTab.text = pastName
        self.getTournamentCategories()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}

//MARK: - ACTION METHODS
extension TournamentListVC{
    @IBAction func btnSwitchTab(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        isUpcoming = !sender.isSelected
        if sender.isSelected{
            lblSelectedTab.text = pastName
            lblNonSelectedTab.text = upcomming
        }
        else{
            lblNonSelectedTab.text = pastName
            lblSelectedTab.text = upcomming
        }
        if sportType == .tournaments{
            self.getTournaments()
        }
        else{
            self.getUpcomingRuns()
        }
    }
    
    @IBAction func btnFilterPressed(_ sender:UIButton){
        self.rightBarPressed()
    }
}


//MARK: - TABLEVIEW DELEGATES
extension TournamentListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportType == .tournaments ? tournaments.count : runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcommingCourtBookingCell", for: indexPath) as! UpcommingCourtBookingCell
        cell.tournamentView.categories = arrCategories
        if sportType == .tournaments{
            cell.tournamentView.tournament = tournaments[indexPath.row]
        }
        else{
            cell.tournamentView.runs = runs[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:TournamentDetailsVC = TournamentDetailsVC.controller()
        
        if isTournament{
            vc.tournament = tournaments[indexPath.row]
            ApplicationManager.tournament = tournaments[indexPath.row]
        }
        else{
            vc.runs = runs[indexPath.row]
            ApplicationManager.runs = runs[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - SPORTS FILTER DELEGATE
extension TournamentListVC{
    override func didApplyFilter(filter: Filter) {
//        print(filter.sport?.id ?? 0)
        self.sports = filter.sport
    }
}

//MARK: - API SERVICES
extension TournamentListVC{
    private func getTournaments(){
        self.startActivityIndicator()
        let endPoint = isUpcoming ? EndPoints.getUpPastTournaments + "upcoming" : EndPoints.getUpPastTournaments + "past"
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .post, endPoint: endPoint, type: CommonResponse<[Tournaments]>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            if let response = success as? CommonResponse<[Tournaments]>, let data = self.successBlock(response: response){
                self.tournaments = data
                self.tableView.reloadData()
            }
        }
    }
    
    private func getTournamentCategories(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .get, endPoint: EndPoints.getTournamentTypes, type: CommonResponse<[TournamentsType]>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<[TournamentsType]> else {return}
            if let data = self.successBlock(response: response){
                self.arrCategories = data
                if self.sportType == .tournaments{
                    self.getTournaments()
                }
                else{
                    self.getUpcomingRuns()
                }
            }
        }
    }
}

//MARK: - RUNS APIS
extension TournamentListVC{
    private func getUpcomingRuns(){
        let endPoint = isUpcoming ? EndPoints.getUpPastRuns + "upcoming" : EndPoints.getUpPastRuns + "past"
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        self.startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: endPoint, type: CommonResponse<[Run]>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            if let response = success as? CommonResponse<[Run]>, let data = self.successBlock(response: response){
                self.runs = data
                self.tableView.reloadData()
            }
        }
    }
}
