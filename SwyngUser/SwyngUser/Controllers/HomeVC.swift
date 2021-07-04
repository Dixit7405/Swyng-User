//
//  HomeVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 25/04/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: BaseVC {
    @IBOutlet weak var clctnBanners:UICollectionView!
    @IBOutlet weak var pageControlBanner:UIPageControl!
    @IBOutlet weak var tblUpcomming:UITableView!
    @IBOutlet weak var nslcUpcommingTableHeight:NSLayoutConstraint!
    @IBOutlet weak var tblMembershipPlans:UITableView!
    @IBOutlet weak var nslcMembershipHeight:NSLayoutConstraint!
    @IBOutlet weak var viewNeedhelpShadow:UIView!
    @IBOutlet weak var viewBulkbookingShadow:UIView!
    @IBOutlet weak var viewUpcommingMain:UIView!
    @IBOutlet weak var tblSportsCoaching:UITableView!
    @IBOutlet weak var nslcSportCoachingHeight:NSLayoutConstraint!
    @IBOutlet weak var viewAccountShadow:UIView!
    @IBOutlet weak var tblTournamentRegistrations:UITableView!
    @IBOutlet weak var tblRunsRegistrations:UITableView!
    @IBOutlet weak var nslcTournamentReg:NSLayoutConstraint!
    @IBOutlet weak var nslcRunsReg:NSLayoutConstraint!
    @IBOutlet weak var scrollView:UIScrollView!
    
    var arrOpenEnquiery:[Bool] = Array(repeating: false, count: 2)
    let disposeBag = DisposeBag()
    var firstTimeOpen = false
    var tournaments:[Tournaments] = []
    var runs:[Run] = []
    var arrCategories:[TournamentsType] = []
    var arrRunsCategories:[RunsCategory] = []
    var tournamentRegistrations:[UpcomingRegistration] = []
    var runsRegistrations:[UpcomingRegistration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        self.addLeftBarButton()
        self.addRightBarButton()
        self.navigationItem.title = "Hello Champion!"
        
        tblUpcomming.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        tblMembershipPlans.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        tblSportsCoaching.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        tblTournamentRegistrations.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        tblRunsRegistrations.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        viewNeedhelpShadow.dropShadow(color: UIColor.black, opacity: 0.5)
        viewBulkbookingShadow.dropShadow(color: UIColor.black, opacity: 0.5)
        viewAccountShadow.dropShadow(color: UIColor.black, opacity: 0.5)
        setupUpcomingTable()
        getProfile()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ApplicationManager.cityId == nil{
            let vc:CitySelectionVC = .controller(storyId: "Main")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        else if firstTimeOpen{
            firstTimeOpen = false
            let vc:AccountInfoVC = AccountInfoVC.controller()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        /*else if ApplicationManager.sportType == nil{
            let vc:ManageCenterVC = .controller()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            return
        }*/
        self.scrollView.isHidden = true
        self.showNoDataLabel()
        isTournament ? getTournamentCategories() : getRunsCategories()
        getTournamentRegistrations()
        getRunsRegistrations()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewNeedhelpShadow.updateShadowPath()
        viewBulkbookingShadow.updateShadowPath()
        viewBulkbookingShadow.updateShadowPath()
    }
    
    func setupUpcomingTable(){
        let arr = Observable.just(["ab", "cd"])
        arr.bind(to: tblUpcomming.rx.items(cellIdentifier: "UpcommingCourtBookingCell", cellType: UpcommingCourtBookingCell.self)){ index, model, cell in
            cell.layoutIfNeeded()
        }
        .disposed(by: disposeBag)
        tblUpcomming.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func setNoDataLabel(){
        if tournamentRegistrations.count != 0 || runsRegistrations.count != 0 || tournaments.count != 0 || runs.count != 0{
            self.hideNoDataLabel()
            scrollView.isHidden = false
        }
    }
}

//MARK: - TABLEVIEW DELEGATES
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UITableView.contentSize){
            nslcUpcommingTableHeight.constant = tblUpcomming.contentSize.height
            nslcMembershipHeight.constant = tblMembershipPlans.contentSize.height
            nslcSportCoachingHeight.constant = tblSportsCoaching.contentSize.height
            nslcRunsReg.constant = tblRunsRegistrations.contentSize.height
            nslcTournamentReg.constant = tblTournamentRegistrations.contentSize.height
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblTournamentRegistrations{
            return tournamentRegistrations.count
        }
        else if tableView == tblRunsRegistrations{
            return runsRegistrations.count
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblTournamentRegistrations{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcommingCourtBookingCell", for: indexPath) as! UpcommingCourtBookingCell
            let tournament = tournamentRegistrations[indexPath.row]
            cell.tournamentView.tournamentRegistration = tournament
            cell.cancelledView.isHidden = (tournament.ticketCategory?.count != 0 && tournament.cancelTicketCategory?.count == 0)
            return cell
        }
        else if tableView == tblRunsRegistrations{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcommingCourtBookingCell", for: indexPath) as! UpcommingCourtBookingCell
            let tournament = runsRegistrations[indexPath.row]
            cell.tournamentView.tournamentRegistration = tournament
            cell.cancelledView.isHidden = (tournament.ticketCategory?.count != 0 && tournament.cancelTicketCategory?.count == 0)
            return cell
        }
        else if tableView == tblSportsCoaching{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SportsCoachingCell", for: indexPath) as! SportsCoachingCell
            cell.isOpenEnquiery = arrOpenEnquiery[indexPath.row]
            cell.enquiryChangeBlock = { isOpen in
                self.arrOpenEnquiery[indexPath.row] = !self.arrOpenEnquiery[indexPath.row]
                self.tblSportsCoaching.reloadSections([0], with: .automatic)
                
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MembershipPlanCell", for: indexPath) as! MembershipPlanCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:BookingReviewVC = BookingReviewVC.controller()
        if tableView == tblTournamentRegistrations{
            vc.pageType = .upcoming
            vc.tournamentId = tournamentRegistrations[indexPath.row].tournamentId
            vc.tournamentName = tournamentRegistrations[indexPath.row].tournamentName
        }
        else if tableView == tblRunsRegistrations{
            vc.pageType = .upcoming
            vc.runId = runsRegistrations[indexPath.row].runId
            vc.runName = runsRegistrations[indexPath.row].runName
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - COLLECTIONVIEW DELEGATES
extension HomeVC:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportType == .tournaments ? tournaments.count : runs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCell", for: indexPath) as! HomeBannerCell
        if sportType == .tournaments{
            cell.categories = arrCategories
            cell.tournament = tournaments[indexPath.item]
        }
        else{
            cell.runsCategories = arrRunsCategories
            cell.runs = runs[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc:TournamentDetailsVC = TournamentDetailsVC.controller()
        if sportType == .tournaments{
            vc.tournament = tournaments[indexPath.row]
            ApplicationManager.tournament = tournaments[indexPath.row]
        }
        else{
            ApplicationManager.runs = runs[indexPath.row]
            vc.runs = runs[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - SCROLLVIEW DELEGATES
extension HomeVC{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == clctnBanners{
            if let indexPath = clctnBanners.indexPathForItem(at: CGPoint(x: scrollView.contentOffset.x+(scrollView.bounds.size.width/2), y: scrollView.bounds.size.height/2)){
                pageControlBanner.currentPage = indexPath.item
            }
        }
    }
}

//MARK: - API SERVICES
extension HomeVC{
    private func getTournamentCategories(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .get, endPoint: EndPoints.getTournamentTypes, type: CommonResponse<[TournamentsType]>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<[TournamentsType]> else {return}
            if let data = self.successBlock(response: response){
                self.arrCategories = data
                self.getAllTournaments()
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
                self.getUpcomingRuns()
            }
        }
    }
    
    
    private func getAllTournaments(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getUpPastTournaments + "upcoming", type: CommonResponse<[Tournaments]>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<[Tournaments]> else {return}
            if let data = self.successBlock(response: response){
                self.tournaments = data
                self.clctnBanners.reloadData()
                self.pageControlBanner.numberOfPages = data.count
            }
            self.setNoDataLabel()
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
                self.clctnBanners.reloadData()
                self.pageControlBanner.numberOfPages = data.count
            }
            self.setNoDataLabel()
        }
    }
    
    private func getTournamentRegistrations(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getTournamentRegistrations, type: CommonResponse<RegistrationList>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<RegistrationList> else {return}
            if let data = successBlock(response: response){
                tournamentRegistrations = data.upcomingRegistration ?? []
                tblTournamentRegistrations.reloadData()
            }
            self.setNoDataLabel()
        }
    }
    
    private func getRunsRegistrations(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getRunsRegistrations, type: CommonResponse<RegistrationList>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<RegistrationList> else {return}
            if let data = successBlock(response: response){
                runsRegistrations = data.upcomingRegistration ?? []
                tblRunsRegistrations.reloadData()
            }
            self.setNoDataLabel()
        }
    }
    
    private func getProfile(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getProfile, type: CommonResponse<Profile>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<Profile> else {return}
            if let data = self.successBlock(response: response){
                ApplicationManager.profileData = data
                self.navigationItem.title = String(format: "Hello %@", data.fname ?? "")
            }
        }
    }
}
