//
//  OptionView.swift
//  Swyng
//
//  Created by Dixit Rathod on 22/05/21.
//

import Foundation
import UIKit

class OptionView:UIView{
    @IBOutlet var view:UIView!
    @IBOutlet weak var roundView:UIView!
    @IBOutlet weak var lblTitle:UILabel!
    var selected:Bool = false{
        didSet{
            roundView.backgroundColor = selected ? UIColor.AppColor.themeColor : UIColor.white
            lblTitle.textColor = selected ? UIColor.white : UIColor.black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        roundView.layer.cornerRadius = roundView.bounds.size.height/2
        super.layoutSubviews()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed(String(describing: OptionView.self), owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
        
    }
}
