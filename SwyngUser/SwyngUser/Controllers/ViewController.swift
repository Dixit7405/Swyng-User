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
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSkipPressed(_ sender:UIButton){
        let vc = UIStoryboard(name: "Dashboard", bundle: nil)
        if let window = AppUtilities.shared().getMainWindow(){
            window.rootViewController = vc.instantiateInitialViewController()
        }
    }


}

