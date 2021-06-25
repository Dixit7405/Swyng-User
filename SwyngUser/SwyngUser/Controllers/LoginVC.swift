//
//  LoginVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var txtfMobileNumber:FirstResponderField!
    
    var fromRegister = false
    var registerData:RegisterParams?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? OTPVC{
            vc.fromRegister = self.fromRegister
            vc.mobileNumber = txtfMobileNumber.text!
        }
    }

}

//MARK: - ACTION METHODS
extension LoginVC{
    @IBAction func btnNextPressed(_ sender:UIButton){
        if !txtfMobileNumber.checkValidation(){
            return
        }
        if fromRegister{
            signupUser()
        }
        else{
            self.sendOTP()
        }
    }
    
}

//MARK: - API Servicesg
extension LoginVC{
    private func sendOTP(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.mobileNo:txtfMobileNumber.text!]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.sendOTP, type: CommonResponse<Register>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            self.stopActivityIndicator()
            guard let response = success as? CommonResponse<Register> else {return}
            if response.success == true{
                self.performSegue(withIdentifier: "OTPSegue", sender: nil)
            }
            else{
                self.showAlertWith(message: response.message ?? "", isConfirmation: false, okTitle: "Ok", cancelTitle: "") { [unowned self] in
                    let vc:FirstNameVC = FirstNameVC.controller(storyId: StoryboardIds.main)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                } cancelPressed: {
                    print("None")
                }
                
                
            }
        }
    }
    
    private func signupUser(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.fname:registerData?.firstName ?? "",
                                   Parameters.lname:registerData?.lastName ?? "",
                                   Parameters.mobileNo:txtfMobileNumber.text!]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.registerUser, type: CommonResponse<Register>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<Register> else {return}
            if let _ = self.successBlock(response: response){
                self.performSegue(withIdentifier: "OTPSegue", sender: nil)
            }
        }
    }
}

