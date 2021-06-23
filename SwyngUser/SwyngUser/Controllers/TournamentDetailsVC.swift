//
//  TournamentDetailsVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 10/05/21.
//

import UIKit

class TournamentDetailsVC: BaseVC {
    @IBOutlet weak var lblAbout:UILabel!
    @IBOutlet weak var lblDateTime:UILabel!
    @IBOutlet weak var lblRegisterBefore:UILabel!
    @IBOutlet weak var lblVenue:UILabel!
    @IBOutlet weak var lblParticipationFees:UILabel!
    @IBOutlet weak var lblRewards:UILabel!
    @IBOutlet weak var lblTournamentsInfo:UILabel!
    @IBOutlet weak var lblPleaseNote:UILabel!
    @IBOutlet weak var lblFAQ:UILabel!
    @IBOutlet weak var lblTerms:UILabel!
    @IBOutlet weak var lblAboutOrganization:UILabel!
    @IBOutlet weak var lblPastUpcomingEventsFrom:UILabel!
    @IBOutlet weak var lblAboutOrganizationHeader:UILabel!
    @IBOutlet weak var lblEventsFromHeader:UILabel!
    @IBOutlet weak var lblAboutTitle:UILabel!
    @IBOutlet weak var lblTournamentInfoTitle:UILabel!
    @IBOutlet weak var stackBidCollection:UIStackView!
    @IBOutlet weak var stackRouteMap:UIStackView!
    @IBOutlet weak var lblBidCollection:UILabel!
    @IBOutlet weak var lblRouteMap:UILabel!
    @IBOutlet weak var btnRegister:UIButton!
    
    
    var tournament:Tournaments?
    var runs:Run?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if runs != nil{
            setupRunspData()
            btnRegister.isHidden = true
        }
        else{
            setuTournamentpData()
        }
        // Do any additional setup after loading the view.
    }
    
}

//MARK: - CUSTOM FUNCTIONS
extension TournamentDetailsVC{
    private func setuTournamentpData(){
        stackRouteMap.isHidden = true
        stackBidCollection.isHidden = true
        lblAbout.text = tournament?.aboutTournament
        let startDate = tournament?.dates?.first?.toCustomDate(.withDay) ?? ""
        let startTime = tournament?.eventStartTime ?? ""
        let reportTime = tournament?.reportingTime ?? ""
        lblDateTime.text = startDate + " " + startTime + "\n" + reportTime
        lblRegisterBefore.text = tournament?.registerBeforeFromStartTime
        lblVenue.text = (tournament?.venueAddress ?? "") + (tournament?.venue ?? "")
        lblParticipationFees.text = tournament?.participationFee
        lblRewards.text = tournament?.rewards
        lblTournamentsInfo.text = tournament?.tournamentInformation
        lblPleaseNote.text = tournament?.pleaseNote
        lblFAQ.text = tournament?.frequentlyAskedQuestion
        lblTerms.text = tournament?.termsAndCondition
        lblAboutOrganization.text = tournament?.aboutOrganizer
//        lblPastUpcomingEventsFrom.text = tournament.
        lblAboutOrganizationHeader.text = "About " + (tournament?.organizer ?? "")
        lblEventsFromHeader.text = "Past/Upcomming events from " + (tournament?.organizer ?? "")
    }
    
    private func setupRunspData(){
        stackRouteMap.isHidden = false
        stackBidCollection.isHidden = false
        lblBidCollection.text = runs?.bidCollection
        lblRouteMap.text = runs?.routeMap
        lblAboutTitle.text = "About \(runs?.runName ?? "")"
        lblTournamentInfoTitle.text = "Run Information"
        lblAbout.text = runs?.aboutRun
        let startDate = runs?.dates?.first?.toCustomDate(.withDay) ?? ""
        let startTime = runs?.eventStartTime ?? ""
        let reportTime = runs?.reportingTime ?? ""
        lblDateTime.text = startDate + " " + startTime + "\n" + reportTime
        lblRegisterBefore.text = runs?.registerBeforeFromStartTime
        lblVenue.text = (runs?.venueAddress ?? "") + (tournament?.venue ?? "")
        lblParticipationFees.text = runs?.participationFees?.toString()
        lblRewards.text = runs?.rewards
        lblTournamentsInfo.text = runs?.runInformation
        lblPleaseNote.text = runs?.pleaseNote
        lblFAQ.text = runs?.frequentlyAsked
        lblTerms.text = runs?.termsAndCondition
        lblAboutOrganization.text = runs?.aboutOrganizer
//        lblPastUpcomingEventsFrom.text = tournament.
        lblAboutOrganizationHeader.text = "About " + (runs?.organizer ?? "")
        lblEventsFromHeader.text = "Past/Upcomming events from " + (runs?.organizer ?? "")
    }
}

//MARK: - ACTION METHODS
extension TournamentDetailsVC{
    
    @IBAction func btnRegisterPressed(_ sender:UIButton){
        let vc:TournamentRegisterVC = TournamentRegisterVC.controller()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnMapTapped(_ sender:UIButton){
        if isTournament{
            guard let url = URL(string: tournament?.venueGoogleMap ?? "") else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else{
            guard let url = URL(string: runs?.venueGoogleMap ?? "") else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnRouteMapTapped(_ sender:UIButton){
        guard let url = URL(string: runs?.routeMap ?? "") else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
