//
//  OptionContainerCell.swift
//  Swyng
//
//  Created by Dixit Rathod on 04/06/21.
//

import UIKit

class OptionContainerCell: UITableViewCell {
    @IBOutlet weak var optionView:OptionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
