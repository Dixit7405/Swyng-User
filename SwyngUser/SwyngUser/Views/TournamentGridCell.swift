//
//  TournamentGridCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 09/05/21.
//

import UIKit

class TournamentGridCell: UICollectionViewCell {
    @IBOutlet weak var lblCategory:UILabel!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblAddressTime:UILabel!
    @IBOutlet weak var lblOpenFor:UILabel!
    @IBOutlet weak var lblRegisterBefore:UILabel!
    @IBOutlet weak var lblPlayerCount:UILabel!
    @IBOutlet weak var imgTournament:UIImageView!
    
    
    var tournament:Tournaments?{
        didSet{
//            lblCategory.text = ""
            lblName.text = tournament?.eventName
            let startDate = tournament?.dates?.first?.convertDate(format: "yyyy-MM-dd").toDate(format: "EEE dd, MMM yyyy") ?? ""
            let startTime = tournament?.eventStartTime ?? ""
            lblAddressTime.text = startDate + " " + (tournament?.venueAddress ?? "")
            lblOpenFor.text = ""
            lblRegisterBefore.text = "Register before \(tournament?.registerBeforeFromStartTime ?? "") of \(startDate) at \(startTime)"
            lblPlayerCount.text = "\(tournament?.noOfPlayers ?? 0) players have registerd"
        }
    }
}
