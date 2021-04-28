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
        self.dropShadow(color: UIColor.black, opacity: 0.5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateShadowPath()
    }
}
