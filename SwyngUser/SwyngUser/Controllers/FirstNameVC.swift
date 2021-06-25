//
//  FirstNameVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class FirstNameVC: UIViewController {
    @IBOutlet weak var txtfFirstName:FirstResponderField!
    
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
            let data = RegisterParams()
            data.firstName = txtfFirstName.text
            vc.registerData = data
        }
    }
}
