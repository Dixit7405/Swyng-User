//
//  UpcomingTournamentVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 10/05/21.
//

import UIKit

class UpcomingTournamentVC: BaseVC {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var lblHeaderName:UILabel!
    @IBOutlet weak var imgHeader:UIImageView!
    
    var tournaments:[Tournaments] = []
    var runs:[Run] = []
    var arrCategories:[TournamentsType] = []
    var arrRunsCategories:[RunsCategory] = []
    var filter:Filter?{
        didSet{
            if isTournament{
                self.filterTournamentData()
            }
            else{
                self.filterRunsData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if sportType == .tournaments{
            lblHeaderName.text = "Upcomming Tournaments"
            imgHeader.image = #imageLiteral(resourceName: "header_tournaments")
        }
        else{
            lblHeaderName.text = "Upcoming Runs"
            imgHeader.image = #imageLiteral(resourceName: "header_run")
        }
        
        if isTournament{
            if arrCategories.count == 0{
                getTournamentCategories()
            }
            else{
                getAllTournaments()
            }
        }
        else{
            if arrRunsCategories.count == 0{
                getRunsCategories()
            }
            else{
                getUpcomingRuns()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

//MARK: - ACTION METHODS
extension UpcomingTournamentVC{
    @IBAction func filterPressed(_ sender:UIButton){
        rightBarPressed()
    }
    
    @IBAction func btnLeftBar(_ sender:UIButton){
        leftBarPressed()
    }
}

//MARK: - TABLEVIEW DELEGATES
extension UpcomingTournamentVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isTournament ? tournaments.count : runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcommingCourtBookingCell", for: indexPath) as! UpcommingCourtBookingCell
        if isTournament{
            cell.tournamentView.categories = arrCategories
            cell.tournamentView.tournament = tournaments[indexPath.row]
        }
        else{
            cell.tournamentView.runsCategories = arrRunsCategories
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

//MARK: - FILTER DELEGATE
extension UpcomingTournamentVC{
    override func didApplyFilter(filter: Filter) {
        super.didApplyFilter(filter: filter)
        if filter.gallery == true{
            let vc:TournamentGridVC = .controller()
            vc.filter = filter
            (tabBarController?.viewControllers?[2] as! NavController).viewControllers = [vc]
        }
        else{
            self.filter = filter
            if isTournament{
                self.filterTournamentData()
            }
            else{
                self.filterRunsData()
            }
        }
    }
}

//MARK: - API SERVICES
extension UpcomingTournamentVC{
    private func getAllTournaments(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getUpPastTournaments + "upcoming", type: CommonResponse<[Tournaments]>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<[Tournaments]> else {return}
            if let data = self.successBlock(response: response){
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
                if self.filter == nil{
                    self.getAllTournaments()
                }
                else{
                    self.filterTournamentData()
                }
                
            }
        }
    }
    
    private func getRunsCategories(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .get, endPoint: EndPoints.getRunsCategory, type: CommonResponse<[RunsCategory]>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<[RunsCategory]> else {return}
            if let data = self.successBlock(response: response){
                self.arrRunsCategories = data
                if self.filter == nil{
                    self.getUpcomingRuns()
                }
                else{
                    self.filterRunsData()
                }
                
            }
        }
    }
    
    private func filterTournamentData(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.sport:filter?.sport.compactMap({$0.id}) ?? [],
                                   Parameters.offset:0,
                                   Parameters.size:10]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.filterTournaments, type: CommonResponse<PagingData<Tournaments>>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<PagingData<Tournaments>> else {return}
            if let data = self.successBlock(response: response){
                self.tournaments = data.data ?? []
                if self.filter?.filter == true{
                    self.tournaments.sort(by: {($0.dates?.first?.convertDate(format: .serverDate) ?? Date()) > ($1.dates?.first?.convertDate(format: .serverDate) ?? Date())})
                }
                self.tableView.reloadData()
            }
        }
    }
    
    private func filterRunsData(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.sport:filter?.sport.compactMap({$0.id}) ?? [],
                                   Parameters.offset:0,
                                   Parameters.size:10]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.filterRuns, type: CommonResponse<PagingData<Run>>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<PagingData<Run>> else {return}
            if let data = self.successBlock(response: response){
                self.runs = data.data ?? []
                if self.filter?.filter == true{
                    self.runs.sort(by: {($0.dates?.first?.convertDate(format: .serverDate) ?? Date()) > ($1.dates?.first?.convertDate(format: .serverDate) ?? Date())})
                }
                self.tableView.reloadData()
            }
        }
    }
    
    private func getUpcomingRuns(){
        let endPoint = EndPoints.getUpPastRuns + "upcoming"
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
