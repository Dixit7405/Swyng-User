//
//  CityCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class CityCell: UICollectionViewCell {
    @IBOutlet weak var lblCityName:UILabel!
    @IBOutlet weak var viewBg:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBg.dropShadow(color: UIColor.black, opacity: 0.5)
    }
    
    override func layoutSubviews() {
        viewBg.updateShadowPath()
    }
    
    override var isSelected: Bool{
        didSet{
            viewBg.backgroundColor = isSelected ? UIColor.AppColor.themeColor : UIColor.white
            lblCityName.textColor = isSelected ? UIColor.white : UIColor.black
        }
    }
}
