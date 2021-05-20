//
//  ParticipantCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 12/05/21.
//

import UIKit

class ParticipantCell: UITableViewCell {
    @IBOutlet weak var lblIndex:UILabel!
    @IBOutlet weak var viewParticipant1:UIView!
    @IBOutlet weak var viewParticipant2:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
