//
//  OTPVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class OTPVC: UIViewController {
    @IBOutlet weak var txtfOTP:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        txtfOTP.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        dismiss(animated: true, completion: nil)
    }

    @IBAction func btnNextPressed(_ sender:UIButton){
        performSegue(withIdentifier: "FirstNameSegue", sender: nil)
    }
}
