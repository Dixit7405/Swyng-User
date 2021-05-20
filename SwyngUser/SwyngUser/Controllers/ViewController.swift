//
//  ViewController.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 23/04/21.
//

import UIKit

class ViewController: UIViewController {
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
    
    @IBAction func btnSkipPressed(_ sender:UIButton){
        let vc = UIStoryboard(name: StoryboardIds.dashboard, bundle: nil)
        if let window = AppUtilities.getMainWindow(){
            window.rootViewController = vc.instantiateInitialViewController()
        }
    }


}

