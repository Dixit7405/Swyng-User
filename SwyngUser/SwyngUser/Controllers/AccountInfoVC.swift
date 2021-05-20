//
//  AccountInfoVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 29/04/21.
//

import UIKit

class AccountInfoVC: UIViewController {
    @IBOutlet weak var txtfFirstName:CustomField!
    @IBOutlet weak var txtfLastName:CustomField!
    @IBOutlet weak var txtfMobile:CustomField!
    @IBOutlet weak var txtfEmail:CustomField!
    @IBOutlet weak var txtfDOB:PickerField!
    @IBOutlet weak var txtfGender:PickerField!
    @IBOutlet weak var txtfBloodGroup:CustomField!
    @IBOutlet weak var txtfTshirtSize:CustomField!
    @IBOutlet weak var txtfEmergencyContactName:CustomField!
    @IBOutlet weak var txtfEmergencyContactNo:CustomField!
    @IBOutlet weak var mainStackView:UIStackView!
    @IBOutlet weak var lblTopText:UILabel!
    
    var cityId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        txtfGender.arrPicker = ["Male", "Female"]
        getProfile()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackPressed(_ sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDoLaterPressed(_ sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSavePressed(_ sender:UIButton){
        var valid = true
        for stack in mainStackView.arrangedSubviews{
            if let sv = stack as? UIStackView{
                for view in sv.arrangedSubviews{
                    if let txtf = view as? CustomField{
                        if !txtf.checkValidation(){
                            valid = false
                        }
                    }
                }
            }
        }
        if valid{
            self.updateProfileData()
        }
    }
}

//MARK: - CUSTOM METHODS
extension AccountInfoVC{
    private func populateData(){
        if let profile = ApplicationManager.profileData{
            lblTopText.text = "\(profile.fname ?? "") \(profile.lname ?? ""), few additional details like emergency contacts & blood group will help us act promptly in case of emergency situations. And few more details to make your transactions go like a breeze.  Rest assured, we NEVER share this information with any third party business/individual without your consent as mentioned in the privacy policy. Cheers :)"
            txtfFirstName.text = profile.fname
            txtfLastName.text = profile.lname
            txtfEmail.text = profile.email
            txtfMobile.text = profile.mobileNo
            txtfDOB.text = profile.dateOfBirth
            txtfGender.text = profile.gender
            txtfBloodGroup.text = profile.bloodGroup
            txtfTshirtSize.text = profile.tShirtSize
            txtfEmergencyContactName.text = profile.emergencyContactName
            txtfEmergencyContactNo.text = profile.emergencyContactNumber
        }
    }
}

//MARK: API SERVICES
extension AccountInfoVC{
    private func getProfile(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getProfile, type: CommonResponse<Profile>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<Profile> else {return}
            if let data = self.successBlock(response: response){
                ApplicationManager.profileData = data
                self.populateData()
            }
        }
    }
    
    private func updateProfileData(){
        let params:[String:Any] = [
            Parameters.fname:txtfFirstName.text!,
            Parameters.lname:txtfLastName.text!,
            Parameters.email:txtfEmail.text!,
            Parameters.mobileNo:txtfMobile.text!,
            Parameters.token:ApplicationManager.authToken ?? "",
            Parameters.dateOfBirth:txtfDOB.text!.toDate,
            Parameters.gender:txtfGender.text!,
            Parameters.bloodGroup:txtfBloodGroup.text!,
            Parameters.tShirtSize:txtfTshirtSize.text!,
            Parameters.emergencyContactName:txtfEmergencyContactName.text!,
            Parameters.emergencyContactNumber:txtfEmergencyContactNo.text!,
            Parameters.cityId:self.cityId
        ]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.updateProfile, type: CommonResponse<Profile>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<Profile> else {return}
            if let data = self.successBlock(response: response){
                ApplicationManager.profileData = data
                self.showAlertWith(message: response.message ?? "") {
                    self.dismiss(animated: true, completion: nil)
                } cancelPressed: {
                    print("None")
                }

            }
        }
    }
}
