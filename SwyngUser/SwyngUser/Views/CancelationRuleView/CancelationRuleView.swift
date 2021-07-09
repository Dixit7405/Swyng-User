//
//  CancelationRuleView.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 04/07/21.
//

import UIKit

class CancelationRuleView: UIView {
    @IBOutlet var view:UIView!
    @IBOutlet weak var lblRule:UILabel!
    @IBOutlet weak var lblPercentage:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    
    private func commonInit(){
        Bundle.main.loadNibNamed(String(describing: CancelationRuleView.self), owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
        
    }
}
