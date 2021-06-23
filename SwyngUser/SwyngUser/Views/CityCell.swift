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
    @IBOutlet weak var optionView:OptionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if viewBg != nil{
            viewBg.dropShadow(color: UIColor.black, opacity: 0.5)
        }
    }
    
    override func layoutSubviews() {
        if viewBg != nil{
            viewBg.updateShadowPath()
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if viewBg != nil{
                viewBg.backgroundColor = isSelected ? UIColor.AppColor.themeColor : UIColor.white
                lblCityName.textColor = isSelected ? UIColor.white : UIColor.black
            }
        }
    }
}
