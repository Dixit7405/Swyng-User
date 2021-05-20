//
//  UpcommingCourtBookingCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 26/04/21.
//

import UIKit

class UpcommingCourtBookingCell: UITableViewCell {
    @IBOutlet weak var viewBg:UIView!
    @IBOutlet weak var lblTournamentDate:UILabel!
    @IBOutlet weak var lblTournamentName:UILabel!
    @IBOutlet weak var lblAddress:UILabel!
    @IBOutlet weak var lblOpenFor:UILabel!
    
    var tournament:Tournaments?{
        didSet{
            let startDate = tournament?.dates?.first?.convertDate(format: "yyyy-MM-dd").toDate(format: "EEE\ndd MMM\nyyyy") ?? ""
//            let startTime = tournament?.eventStartTime ?? ""
            lblTournamentDate.text = startDate
            lblTournamentName.text = tournament?.eventName
            lblOpenFor.text = ""
            lblAddress.text = tournament?.venueAddress
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
