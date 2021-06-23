//
//  TournamentGridVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 09/05/21.
//

import UIKit

class TournamentGridVC: BaseVC {
    @IBOutlet weak var collectionView:UICollectionView!
    
    var tournaments:[Tournaments] = []
    var runs:[Run] = []
    var filter:Filter?{
        didSet{
            if isTournament{
                filterTournamentData()
            }
            else{
                filterRunsData()
            }
        }
    }
    var arrCategories:[TournamentsType] = []
    var arrRunsCategories:[RunsCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLeftBarButton()
        self.addRightBarButton()
        
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isTournament{
            getTournamentCategories()
        }
        else{
            getRunsCategories()
        }
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredVertically, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

//MARK: - ACTION METHOD
extension TournamentGridVC{
        
}

//MARK: - COLLECTIONVIEW DELEGATE
extension TournamentGridVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportType == .tournaments ? tournaments.count : runs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TournamentGridCell", for: indexPath) as! TournamentGridCell
        if sportType == .tournaments{
            cell.categories = arrCategories
            cell.tournament = tournaments[indexPath.item]
        }
        else{
            cell.runsCategories = arrRunsCategories
            cell.runs = runs[indexPath.row]
        }
        cell.delegate = self
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


//MARK: - API SERVICES
extension TournamentGridVC{
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
    
    
    private func getAllTournaments(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getUpPastTournaments + "upcoming", type: CommonResponse<[Tournaments]>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<[Tournaments]> else {return}
            if let data = self.successBlock(response: response){
                self.tournaments = data
                self.collectionView.reloadData()
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
                self.collectionView.reloadData()
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
                self.collectionView.reloadData()
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
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: - SPORTS FILTER DELEGATE
extension TournamentGridVC{
    override func didApplyFilter(filter: Filter) {
        print("Filter pressed")
        if filter.gallery == false{
            let vc:UpcomingTournamentVC = .controller()
            vc.filter = filter
            (tabBarController?.viewControllers?[2] as! NavController).viewControllers = [vc]
        }
        else{
            self.filter = filter
            if isTournament{
                filterTournamentData()
            }
            else{
                filterRunsData()
            }
        }
    }
}

//MARK: - TournamentCellDelegate
extension TournamentGridVC:TournamentGridDelegate{
    func didTapRegister(run: Run?) {
        let vc:TournamentRegisterVC = TournamentRegisterVC.controller()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapDetails(run: Run?) {
        let vc:TournamentDetailsVC = TournamentDetailsVC.controller()
        vc.runs = run
        ApplicationManager.runs = run
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapRegister(tournament: Tournaments?) {
        let vc:TournamentRegisterVC = TournamentRegisterVC.controller()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapDetails(tournament: Tournaments?) {
        let vc:TournamentDetailsVC = TournamentDetailsVC.controller()
        vc.tournament = tournament
        ApplicationManager.tournament = tournament
        navigationController?.pushViewController(vc, animated: true)
    }
}
