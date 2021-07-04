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
    
    var controller:UIViewController?
    
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
        AppUtilities.logoutUser()
        AppUtilities.setRootController()
    }
    
    @IBAction func btnCallPressed(_ sender:UIButton){
        if let url = URL(string: "tel://+919108475471"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnEmailPressed(_ sender:UIButton){
        if let url = URL(string: "mailto:hello@swyng.in"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnWhatsappPressed(_ sender:UIButton){
        let phoneNumber =  "+919108475471" // you need to change this number
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        } else {
            controller?.showAlertWith(message: "Whatsapp is not installed")
        }

    }
    
    @IBAction func btnSharePressed(_ sender:UIButton){
        guard let url = URL(string: AppDetails.appURL) else {return}
        let textShare = [ url] as [Any]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self
        controller?.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func btnFacebookPressed(_ sender:UIButton){
        if let url = URL(string: "https://www.facebook.com/helloswyng"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnTwitterPressed(_ sender:UIButton){
        if let url = URL(string: "https://twitter.com/helloswyng"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnInstagramPressed(_ sender:UIButton){
        if let url = URL(string: "https://www.instagram.com/helloswyng"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnYoutubePressed(_ sender:UIButton){
        if let url = URL(string: "https://www.linkedin.com/company/swyng"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
