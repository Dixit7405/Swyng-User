//
//  LoginVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var txtfMobileNumber:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtfMobileNumber.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

}

//MARK: - ACTION METHODS
extension LoginVC{
    @IBAction func btnNextPressed(_ sender:UIButton){
        self.performSegue(withIdentifier: "OTPSegue", sender: nil)
    }
    
}
