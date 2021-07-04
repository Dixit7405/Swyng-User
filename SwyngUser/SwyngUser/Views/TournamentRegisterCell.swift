//
//  TournamentRegisterCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 11/05/21.
//

import UIKit

class TournamentRegisterCell: UITableViewCell {
    @IBOutlet weak var btnSelection:UIButton!
    @IBOutlet weak var lblCategory:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var stepperView:StepperView!
    
    var tournamentTicket:TournamentTicket?{
        didSet{
            lblPrice.text =  tournamentTicket?.participationFees
            lblCategory.text = tournamentTicket?.tournamentCategory?.name
            lblPrice.textColor = (tournamentTicket?.isBookingAvailable ?? false) ? UIColor.black : UIColor.lightGray
            lblCategory.textColor = (tournamentTicket?.isBookingAvailable ?? false) ? UIColor.black : UIColor.lightGray
        }
    }
    
    var runsTicket:RunsTicket?{
        didSet{
            lblPrice.text =  runsTicket?.participationFees
            lblCategory.text = runsTicket?.runCategory?.name
            stepperView.maxValue = runsTicket?.allowedEntries ?? 0
            stepperView.currentIndex = 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
