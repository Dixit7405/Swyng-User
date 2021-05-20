//
//  ShadowView.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 28/04/21.
//

import UIKit

class ShadowView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dropShadow(color: UIColor.AppColor.appBlack ?? UIColor.black, opacity: 0.5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateShadowPath()
    }
}

class ShadowButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dropShadow(color: UIColor.AppColor.appBlack ?? UIColor.black, opacity: 0.5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateShadowPath()
    }
}

class SelectableButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addTarget(self, action: #selector(didSelectButton(sender:)), for: .touchUpInside)
    }
    
    @objc private func didSelectButton(sender:UIButton){
        sender.isSelected = !sender.isSelected
    }
}
