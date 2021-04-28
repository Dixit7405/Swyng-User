//
//  AccountMenuCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 27/04/21.
//

import UIKit

class AccountMenuCell: UICollectionViewCell {
    @IBOutlet weak var viewShadow:UIView!
    @IBOutlet weak var titleLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewShadow.updateShadowPath()
    }
    
}
