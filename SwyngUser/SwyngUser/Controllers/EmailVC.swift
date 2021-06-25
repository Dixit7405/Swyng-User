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
        updateEmail()
    }

}

//MARK: - API SERVICES
extension EmailVC{
    fileprivate func updateEmail(){
        let params:[String:Any] = [Parameters.email:txtfEmail.text!,
                                   Parameters.token:ApplicationManager.authToken ?? ""]
        self.startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.updateEmail, type: CommonResponse<Profile>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<Profile> else {return}
            if let _ = self.successBlock(response: response){
                self.performSegue(withIdentifier: "GetStartedSegue", sender: nil)
            }
            
        }
    }
}
