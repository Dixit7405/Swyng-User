//
//  LastNameVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class LastNameVC: UIViewController {
    @IBOutlet weak var txtfLastName:FirstResponderField!
    var firstName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        dismiss(animated: true, completion: nil)
    }

    @IBAction func btnNextPressed(_ sender:UIButton){
        if !txtfLastName.checkValidation() {
            return
        }
        performSegue(withIdentifier: "EmailIdSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EmailVC{
            vc.firstName = self.firstName
            vc.lastName = txtfLastName.text!
        }
    }
}
