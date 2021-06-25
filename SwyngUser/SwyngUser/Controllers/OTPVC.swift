//
//  OTPVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class OTPVC: UIViewController {
    @IBOutlet weak var txtfOTP:FirstResponderField!
    
    var fromRegister = false
    var mobileNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        dismiss(animated: true, completion: nil)
    }

    @IBAction func btnNextPressed(_ sender:UIButton){
        self.verifyOTP()
    }
    
    @IBAction func btnResendPressed(_ sender:UIButton){
        sendOTP()
    }
}

//MARK: - API SERVICES
extension OTPVC{
    private func verifyOTP(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.mobileNo:mobileNumber,
                                   Parameters.otp:txtfOTP.text!]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.verifyOTP, type: CommonResponse<Register>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<Register> else {return}
            if let data = self.successBlock(response: response){
                ApplicationManager.authToken = data.token
                if self.fromRegister{
                    let vc:EmailVC = EmailVC.controller(storyId: StoryboardIds.main)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
                else{
                    AppUtilities.setRootController()
                }
            }
            else{
                self.txtfOTP.text = ""
            }
        }
    }
    
    private func sendOTP(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.mobileNo:mobileNumber]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.sendOTP, type: CommonResponse<Register>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            self.stopActivityIndicator()
            guard let response = success as? CommonResponse<Register> else {return}
            self.showAlertWith(message: response.message ?? "")
        }
    }
}
