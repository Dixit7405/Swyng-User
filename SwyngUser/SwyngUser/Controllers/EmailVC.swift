//
//  EmailVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class EmailVC: UIViewController {
    @IBOutlet weak var txtfEmail:FirstResponderField!
    var firstName = ""
    var lastName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBackPressed(_ sender:UIButton){
        dismiss(animated: true, completion: nil)
    }

    @IBAction func btnNextPressed(_ sender:UIButton){
        if !txtfEmail.checkValidation() {
            return
        }
        signUpUser()
    }

}

//MARK: - API SERVICES
extension EmailVC{
    fileprivate func signUpUser(){
        let params:[String:Any] = [Parameters.fname:firstName,
                                   Parameters.lname:lastName,
                                   Parameters.email:txtfEmail.text!]
        self.startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.registerUser, type: CommonResponse<Register>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<Register> else {return}
            if let data = self.successBlock(response: response){
                ApplicationManager.authToken = data.token
                self.performSegue(withIdentifier: "GetStartedSegue", sender: nil)
            }
            
        }
    }
}
