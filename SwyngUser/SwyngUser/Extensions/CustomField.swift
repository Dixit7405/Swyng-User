//
//  UITextfield+Extension.swift
//  Goocab
//
//  Created by Dixit Rathod on 04/04/21.
//

import Foundation
import UIKit

//MARK: - TEXTFIELD DELEGATE
class CustomField: UITextField{
    @IBInspectable var isEmail:Bool = false{
        didSet{
            self.type = .email
        }
    }
    
    @IBInspectable var isPassword:Bool = false{
        didSet{
            type = .password
        }
    }
    
    @IBInspectable var isDateOfBirth:Bool = false{
        didSet{
            type = .dob
        }
    }
    
    @IBInspectable var isFirstName:Bool = false{
        didSet{
            type = .firstname
        }
    }
    
    @IBInspectable var isLastName:Bool = false{
        didSet{
            type = .lastname
        }
    }
    
    @IBInspectable var isMobile:Bool = false{
        didSet{
            type = .mobile
        }
    }
    
    @IBInspectable var isGender:Bool = false{
        didSet{
            type = .gender
        }
    }
    
    private var validateString:TextfieldValidations = .otherValidation{
        didSet{
            showValidationMessage()
        }
    }
    
    
    @IBInspectable var isMandatory:Bool = true
    
    var type:TextfieldType = .other
    
    enum TextfieldType{
        case email
        case password
        case dob
        case firstname
        case lastname
        case mobile
        case gender
        case other
    }
    
    enum TextfieldValidations:String{
        case emptyPassword = "Please enter password"
        case passwordLength = "Password length should be at least 6 digit"
        case invalidEmail = "Please enter valid email"
        case emptyDOB = "Please select date of birth"
        case invalidFirstName = "Please enter valid First Name"
        case invalidLastName = "Please enter valid Last Name"
        case invalidMobile = "Please enter valid mobile number"
        case otherValidation = "Please enter something"
    }
    
    
    private func showValidationMessage(){
        self.text = ""
        let validation = validateString == .otherValidation ? "\(self.placeholder ?? "field") can not be empty" : validateString.rawValue
        self.attributedPlaceholder = NSAttributedString(string: validation, attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
    }
    
    func checkValidation() -> Bool{
        if !isMandatory, self.text!.isEmpty(){
            return true
        }
        switch type {
        case .email:
            if !self.text!.isValidEmail(){
                validateString = .invalidEmail
                return false
            }
        case .password:
            if self.isMandatory, self.text!.isEmpty(){
                validateString = .emptyPassword
                return false
            }
            else if self.text!.count < 6{
                validateString = .passwordLength
                return false
            }
        case .dob:
            if self.text!.isEmpty(){
                validateString = .emptyDOB
                return false
            }
        case .firstname:
            if !self.text!.isValidName{
                validateString = .invalidFirstName
                return false
            }
        case .lastname:
            if !self.text!.isValidName{
                validateString = .invalidLastName
                return false
            }
        case .mobile:
            if !self.text!.isValidPhoneNumber || self.text!.count != 10{
                validateString = .invalidMobile
                return false
            }
        case .other, .gender:
            if !self.text!.hasValidText{
                validateString = .otherValidation
                return false
            }
        }
        return true
    }
    
}

//MARK: - STRING
extension String{
    func isValidEmail() -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+[.][A-Za-z]{2,64}$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func hasAlphabets() -> Bool{
        let letters = NSCharacterSet.letters

        let range = self.rangeOfCharacter(from: letters)

        // range will be nil if no letters is found
        if range  != nil{
            return true
        }
        else {
            return false
        }
    }
    
    var hasValidText:Bool{
        get{
            return self.trim().count != 0
        }
    }
    
    func isEmpty() -> Bool
    {
        if self.trimmingCharacters(in: .whitespaces).count == 0
        {
            return true
        }
        return false
    }
    
    var isValidName: Bool {
        let RegEx = "^[a-zA-Z \\_]{2,25}$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: self)
    }
    
    func convertDate(format:String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self) ?? Date()
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in : CharacterSet.whitespacesAndNewlines)
    }
    
    var isValidPhoneNumber: Bool {
        let charcter  = NSCharacterSet(charactersIn: "+0123456789").inverted
        var filtered:NSString!
        let inputString:NSArray = self.components(separatedBy:charcter) as NSArray
        filtered = inputString.componentsJoined(by: "") as NSString
        return  self == filtered as String

    }
}
