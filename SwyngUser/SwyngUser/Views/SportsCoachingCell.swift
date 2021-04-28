//
//  SportsCoachingCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 27/04/21.
//

import UIKit

class SportsCoachingCell: UITableViewCell {
    @IBOutlet weak var viewEnquiryContainer:UIView!
    @IBOutlet weak var viewEnquiryBtn:UIView!
    @IBOutlet weak var viewDropShadow:UIView!
    
    
    typealias EnquiryBlock = ((Bool) -> Void)
    var enquiryChangeBlock:EnquiryBlock?
    
    var isOpenEnquiery:Bool = false{
        didSet{
            viewEnquiryBtn.isHidden = isOpenEnquiery
            viewEnquiryContainer.isHidden = !isOpenEnquiery
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewDropShadow.dropShadow(color: UIColor.black, opacity: 0.5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewDropShadow.updateShadowPath()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func btnEnquiryPressed(_ sender:UIButton){
        
        if let enquiry = enquiryChangeBlock{
            enquiry(true)
        }
    }
    
    @IBAction func btnCancelEnquiry(_ sender:UIButton){
        if let enquiry = enquiryChangeBlock{
            enquiry(false)
        }
    }
}
