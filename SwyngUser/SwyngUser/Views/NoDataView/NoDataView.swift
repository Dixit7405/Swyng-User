//
//  NoDataView.swift
//  Swyng
//
//  Created by Dixit Rathod on 03/07/21.
//

import UIKit

class NoDataView: UIView {

    @IBOutlet var view:UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed(String(describing: NoDataView.self), owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
    }

}
