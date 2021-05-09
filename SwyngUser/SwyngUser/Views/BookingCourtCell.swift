//
//  BookingCourtCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 06/05/21.
//

import UIKit

class BookingCourtCell: UITableViewCell {
    @IBOutlet weak var stackView:UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let view = Bundle.main.loadNibNamed("BookingSlotView", owner: self, options: nil)![0] as! BookingSlotView
        stackView.addArrangedSubview(view)
        view.layoutIfNeeded()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
