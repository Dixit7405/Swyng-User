//
//  UpcommingCourtBookingCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 26/04/21.
//

import UIKit

class UpcommingCourtBookingCell: UITableViewCell {
    @IBOutlet weak var viewBg:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        viewBg.dropShadow(color: UIColor.black, opacity: 0.5)
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewBg.updateShadowPath()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
