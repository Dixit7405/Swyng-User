//
//  BookingListVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 08/05/21.
//

import UIKit

class BookingListVC: UIViewController {
    @IBOutlet weak var lblSelectedTab:UILabel!
    @IBOutlet weak var lblNonSelectedTab:UILabel!
    @IBOutlet weak var imgHeader:UIImageView!
    @IBOutlet weak var tableView:UITableView!
    
    var isUpcoming = true
    var sportType:SportType = .tournaments
    var pastName = "Past Registration"
    var upcomingName = "Upcoming Registration"
    var upcomingRegistrations:[UpcomingRegistration] = []
    var pastRegistrations:[UpcomingRegistration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblSelectedTab.text = upcomingName
        lblNonSelectedTab.text = pastName
        imgHeader.image = sportType == .run ? #imageLiteral(resourceName: "goal_blue 1") : #imageLiteral(resourceName: "header_tournaments")
        sportType == .tournaments ? getTournamentRegistrations() : getRunsRegistrations()
        // Do any additional setup after loading the view.
    }

}

//MARK: - ACTION METHODS
extension BookingListVC{
    @IBAction func btnSwitchTab(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        isUpcoming = !sender.isSelected
        if sender.isSelected{
            lblSelectedTab.text = pastName
            lblNonSelectedTab.text = upcomingName
        }
        else{
            lblNonSelectedTab.text = pastName
            lblSelectedTab.text = upcomingName
        }
        tableView.reloadData()
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - TABLEVIEW DELEGATES
extension BookingListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isUpcoming ? upcomingRegistrations.count : pastRegistrations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcommingCourtBookingCell", for: indexPath) as! UpcommingCourtBookingCell
        let tournament = isUpcoming ? upcomingRegistrations[indexPath.row] : pastRegistrations[indexPath.row]
        cell.tournamentView.tournamentRegistration = tournament
        cell.cancelledView.isHidden = (tournament.ticketCategory?.count != 0 && tournament.cancelTicketCategory?.count == 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:BookingReviewVC = BookingReviewVC.controller()
        if sportType == .tournaments{
            vc.pageType = isUpcoming ? .upcoming : .confirmed
            vc.tournamentId = isUpcoming ? upcomingRegistrations[indexPath.row].tournamentId : pastRegistrations[indexPath.row].tournamentId
            vc.tournamentName = isUpcoming ? upcomingRegistrations[indexPath.row].tournamentName : pastRegistrations[indexPath.row].tournamentName
        }
        else{
            vc.pageType = isUpcoming ? .upcoming : .confirmed
            vc.runId = isUpcoming ? upcomingRegistrations[indexPath.row].runId : pastRegistrations[indexPath.row].runId
            vc.runName = isUpcoming ? upcomingRegistrations[indexPath.row].runName : pastRegistrations[indexPath.row].runName
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - BOOKING LIST
extension BookingListVC{
    private func getTournamentRegistrations(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getTournamentRegistrations, type: CommonResponse<RegistrationList>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<RegistrationList> else {return}
            if let data = successBlock(response: response){
                upcomingRegistrations = data.upcomingRegistration ?? []
                pastRegistrations = data.pastRegistration ?? []
                tableView.reloadData()
            }
        }
    }
    
    private func getRunsRegistrations(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getRunsRegistrations, type: CommonResponse<RegistrationList>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<RegistrationList> else {return}
            if let data = successBlock(response: response){
                upcomingRegistrations = data.upcomingRegistration ?? []
                pastRegistrations = data.pastRegistration ?? []
                tableView.reloadData()
            }
        }
    }
}
