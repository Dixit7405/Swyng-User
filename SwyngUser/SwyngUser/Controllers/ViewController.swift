//
//  ViewController.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 23/04/21.
//

import UIKit

class ViewController: BaseVC {
    @IBOutlet weak var loginView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.loginView.isHidden = false
            if ApplicationManager.authToken != nil{
                AppUtilities.setRootController()
            }
        }
    }

    @IBAction func btnTermsPressed(_ sender:UIButton){
        let vc:CMSVC = CMSVC.controller()
        let vm = CMSViewModel()
        vc.modalPresentationStyle = .fullScreen
        vm.type.accept(.terms)
        vm.image.accept(.terms)
        vc.viewModel = vm
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btnPrivacyPressed(_ sender:UIButton){
        let vc:CMSVC = CMSVC.controller()
        let vm = CMSViewModel()
        vc.modalPresentationStyle = .fullScreen
        vm.type.accept(.privacy)
        vm.image.accept(.privacy)
        vc.viewModel = vm
        present(vc, animated: true, completion: nil)
    }

}

