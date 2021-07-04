//
//  UpcommingCourtBookingCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 26/04/21.
//

import UIKit

class UpcommingCourtBookingCell: UITableViewCell {
    @IBOutlet weak var tournamentView:TournamentListView!
    @IBOutlet weak var cancelledView:UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
