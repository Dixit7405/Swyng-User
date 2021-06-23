//
//  EventMenuFooter.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 28/04/21.
//

import UIKit

class EventMenuFooter: UICollectionReusableView {
    @IBOutlet weak var contactUsView:UIView!
    @IBOutlet weak var socialMediaView:UIView!
    @IBOutlet weak var sharingView:UIView!
    @IBOutlet weak var logoutView:UIView!
    
    var kind:String = UICollectionView.elementKindSectionHeader{
        didSet{
            if kind == UICollectionView.elementKindSectionHeader{
                contactUsView.isHidden = true
                socialMediaView.isHidden = true
                logoutView.isHidden = true
                sharingView.isHidden = false
            }
            else{
                contactUsView.isHidden = false
                socialMediaView.isHidden = false
                logoutView.isHidden = false
                sharingView.isHidden = true
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func btnLogoutPressed(_ sender:UIButton){
        ApplicationManager.authToken = nil
        ApplicationManager.profileData = nil
        AppUtilities.setRootController()
    }
    
}
