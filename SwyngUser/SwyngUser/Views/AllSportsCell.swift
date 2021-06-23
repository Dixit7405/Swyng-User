//
//  AllSportsCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 04/05/21.
//

import UIKit

class AllSportsCell: UITableViewCell {
    @IBOutlet weak var imgStar:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblAddress:UILabel!
    
    var sportCenter:SportCenters?{
        didSet{
            lblTitle.text = sportCenter?.centerTitle
            lblAddress.text = sportCenter?.sportCenter
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
