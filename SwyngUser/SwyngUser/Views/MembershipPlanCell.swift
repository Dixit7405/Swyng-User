//
//  MembershipPlanCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 26/04/21.
//

import UIKit

class MembershipPlanCell: UITableViewCell {
    @IBOutlet weak var imgPlanLabel:UIImageView!
    @IBOutlet weak var viewShadow:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        viewShadow.dropShadow(color: UIColor.black, opacity: 0.5)
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewShadow.updateShadowPath()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
