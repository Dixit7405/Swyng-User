//
//  UpcomingTournamentVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 10/05/21.
//

import UIKit

class UpcomingTournamentVC: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    
    var tournaments:[Tournaments] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllTournaments()
        // Do any additional setup after loading the view.
    }

}

//MARK: - TABLEVIEW DELEGATES
extension UpcomingTournamentVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournaments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcommingCourtBookingCell", for: indexPath) as! UpcommingCourtBookingCell
        cell.tournament = tournaments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:TournamentDetailsVC = TournamentDetailsVC.controller()
        vc.tournament = tournaments[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - API SERVICES
extension UpcomingTournamentVC{
    private func getAllTournaments(){
        startActivityIndicator()
        Webservices().request(with: [:], method: .get, endPoint: EndPoints.getTournaments, type: CommonResponse<[Tournaments]>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<[Tournaments]> else {return}
            if let data = self.successBlock(response: response){
                self.tournaments = data
                self.tableView.reloadData()
            }
        }
    }
}
