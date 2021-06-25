//
//  TournamentsParticipantsVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 12/05/21.
//

import UIKit

class TournamentsParticipantsVC: BaseVC {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var nslcCollectionHeight:NSLayoutConstraint!
    @IBOutlet weak var nslcTableHeight:NSLayoutConstraint!
    
    var arrCategories:[TournamentsType] = []
    var arrRunsCategory:[RunsCategory] = []
    enum SelectedTournaments {
        case mens
        case woments
        case mixed
    }
    var tournamentId = ApplicationManager.tournament?.tournamentId ?? 0
    var runsId = ApplicationManager.runs?.id ?? 0
    var selected = 0
    var arrParticipants:[Participants] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.lblHeader.text = ApplicationManager.sportType == .tournaments ? "Swyng Badminton Open Tournament Participants" : "Swyng WTF Run Participants"
        collectionView.addObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize), options: .new, context: nil)
        tableView.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
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
    }
}

//MARK: - CUSTOM METHODS
extension TournamentsParticipantsVC{
    func getFullname(participant:Participants) -> String{
        var fullName = ""
        if let fname = participant.fname{fullName.append(fname); fullName.append(" ")}
        if let lname = participant.lname{fullName.append(lname)}
        return fullName
    }
    
    func getFullname1(participant:Participants) -> String{
        var fullName = ""
        if let fname = participant.fname1{fullName.append(fname); fullName.append(" ")}
        if let lname = participant.lname1{fullName.append(lname)}
        return fullName
    }
}

//MARK: - COLLECTIONVIEW DELEGATES
extension TournamentsParticipantsVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nslcCollectionHeight.constant = collectionView.contentSize.height + 32
        nslcTableHeight.constant = tableView.contentSize.height + 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isTournament ? arrCategories.count : arrRunsCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionsCell", for: indexPath) as! OptionsCell
        cell.optionView.lblTitle.text = isTournament ? arrCategories[indexPath.item].name : arrRunsCategory[indexPath.item].name
        cell.optionView.selected = indexPath.item == selected
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = indexPath.item
        collectionView.reloadData()
        if isTournament{
            getParticipantList()
        }
        else{
            getRunsParticipants()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 32)/2
        return CGSize(width: width, height: 70)
    }
}

//MARK: - TABLEVIEW DELEGATE
extension TournamentsParticipantsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrParticipants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath) as! ParticipantCell
        
        let participant = arrParticipants[indexPath.row]
        cell.viewParticipant1.backgroundColor = UIColor.white
        cell.lblParticipant1.textColor = UIColor.AppColor.appBlack
        let hidePart2 = isTournament ? arrCategories[selected].isSingle == true : arrRunsCategory[selected].isSingle == true//(participant.fname1 == "" && participant.lname1 == "") || (participant.fname1 == nil && participant.lname1 == nil)
        cell.viewParticipant2.isHidden = hidePart2
        cell.lblIndex.text = "\(indexPath.row + 1)"
        cell.lblParticipant1.text = getFullname(participant: participant)
        cell.lblParticipant2.text = getFullname1(participant: participant)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


//MARK: - API SERVICES
extension TournamentsParticipantsVC{
    private func getTournamentCategories(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .get, endPoint: EndPoints.getTournamentTypes, type: CommonResponse<[TournamentsType]>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<[TournamentsType]> else {return}
            if let data = self.successBlock(response: response){
                self.arrCategories = data
                self.collectionView.reloadData()
                self.getParticipantList()
            }
        }
    }
    
    private func getRunsCategories(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .get, endPoint: EndPoints.getRunsCategory, type: CommonResponse<[RunsCategory]>.self, failer: failureBlock()) { success in
            guard let response = success as? CommonResponse<[RunsCategory]> else {return}
            if let data = self.successBlock(response: response){
                self.arrRunsCategory = data
                self.collectionView.reloadData()
                self.getRunsParticipants()
            }
        }
    }
    
    
    private func getParticipantList(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.id:tournamentId,
                                   Parameters.tournamentCategoryId:arrCategories[selected].tournamentCategoryId ?? 0]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getParticipantList, type: CommonResponse<[Participants]>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            if let response = success as? CommonResponse<[Participants]>, let data = self.successBlock(response: response){
                self.arrParticipants = data
                self.tableView.reloadData()
            }
        }
    }
    
    private func getRunsParticipants(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.runsCategoryId:arrRunsCategory[selected].runCategoriesId ?? 0,
                                   Parameters.id:runsId]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getRunsParticipants, type: CommonResponse<[Participants]>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            if let response = success as? CommonResponse<[Participants]>, let data = self.successBlock(response: response){
                self.arrParticipants = data
                self.tableView.reloadData()
            }
        }
    }
}
