//
//  FirstNameVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class FirstNameVC: UIViewController {
    @IBOutlet weak var txtfFirstName:FirstResponderField!
    var registerData:RegisterParams?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnNextPressed(_ sender:UIButton){
        if !txtfFirstName.checkValidation() {
            return
        }
        performSegue(withIdentifier: "LastNameSegue", sender: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? LastNameVC{
            registerData?.firstName = txtfFirstName.text
            vc.registerData = registerData
        }
    }
}
