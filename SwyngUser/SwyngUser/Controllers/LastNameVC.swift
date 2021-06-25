//
//  LastNameVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class LastNameVC: UIViewController {
    @IBOutlet weak var txtfLastName:FirstResponderField!
    
    var registerData:RegisterParams?
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
        //performSegue(withIdentifier: "EmailIdSegue", sender: nil)
        registerData?.lastName = txtfLastName.text
        let vc:LoginVC = LoginVC.controller(storyId: StoryboardIds.main)
        vc.fromRegister = true
        vc.registerData = registerData
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
