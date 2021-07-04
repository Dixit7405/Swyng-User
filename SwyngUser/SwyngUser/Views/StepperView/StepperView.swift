//
//  StepperView.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 04/07/21.
//

import UIKit

class StepperView: UIView {
    @IBOutlet var view:UIView!
    @IBOutlet weak var lblValue:UILabel!
    @IBOutlet weak var btnPlus:UIButton!
    @IBOutlet weak var btnMinus:UIButton!
    
    var maxValue:Int = 0
    var currentIndex:Int = 0{
        didSet{
            lblValue.text = String(format: "%02d", currentIndex)
            btnPlus.tintColor = UIColor.blue
            btnMinus.tintColor = UIColor.blue
            if currentIndex == 0{
                btnMinus.tintColor = UIColor.lightGray
            }
            if currentIndex == maxValue{
                btnPlus.tintColor = UIColor.lightGray
            }
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
    
    private func commonInit(){
        Bundle.main.loadNibNamed(String(describing: StepperView.self), owner: self, options: nil)
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func btnPlusPressed(_ sender:UIButton){
        if currentIndex < maxValue{
            currentIndex += 1
        }
    }
    
    @IBAction func btnMinusPressed(_ sender:UIButton){
        if currentIndex > 0{
            currentIndex -= 1
        }
    }
}
