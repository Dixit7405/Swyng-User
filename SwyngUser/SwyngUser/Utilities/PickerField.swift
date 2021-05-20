//
//  PickerField.swift
//  Cupidknot
//
//  Created by Sassy Infotech on 26/09/19.
//  Copyright © 2019 sassyinfotech. All rights reserved.
//

import Foundation
import UIKit

class PickerField:CustomField
{
 
    var picker = UIPickerView()
    var selectedDate = Date()
    
    var datePicker = UIDatePicker()
    
    @IBInspectable var showArrow:Bool = true{
        didSet{
            if showArrow{
                let arrow = UIImageView()
                arrow.image = nil//#imageLiteral(resourceName: "down_arrow")
                arrow.tag = 10
                self.addSubview(arrow)
                arrow.snp.makeConstraints({
                    $0.centerY.equalToSuperview()
                    $0.trailing.equalToSuperview()
                })
            }
            else{
                self.viewWithTag(10)?.removeFromSuperview()
            }
        }
    }
    
    @IBInspectable var isDatePicker:Bool = false{
        didSet{
            datePicker = UIDatePicker()
            datePicker.date = Date()
            datePicker.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            datePicker.addTarget(self, action: #selector(datePickerDidChange), for: .valueChanged)
            self.inputView = datePicker
            
        }
    }
    
    @objc func cancelNumberPad() {
        //Cancel with number pad
        self.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        if isDatePicker{
            selectedDate = datePicker.date
            if datePicker.datePickerMode == .time{
                self.text = selectedDate.toDate(format: "hh:mm")
            }
            else{
                self.text = selectedDate.toDate(format: "yyyy-MM-dd")
            }
        }
        else{
            if self.text == ""{
                self.text = arrPicker.first
            }
        }
        self.resignFirstResponder()
    }
    
    
    var arrPicker:[String] = []{
        didSet{
            picker.reloadAllComponents()
            if self.text?.trim() != "", arrPicker.count != 0{
                let index = arrPicker.firstIndex(of: self.text!) ?? 0
                picker.selectRow(index, inComponent: 0, animated: false)
            }
        }
    }
    
    
    override func awakeFromNib() {
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
        UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        self.inputAccessoryView = numberToolbar
        
        if !isDatePicker{
            picker.delegate = self
            picker.dataSource = self
            self.inputView = picker
        }
    }
    
    @objc private func datePickerDidChange(){
        selectedDate = datePicker.date
        if datePicker.datePickerMode == .time{
            self.text = selectedDate.toDate(format: "hh:mm")
        }
        else{
            self.text = selectedDate.toDate(format: "yyyy-MM-dd")
        }
    }
}

//MARK: - PICKER DELEGATES
extension PickerField:UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arrPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if arrPicker.count != 0{
            self.text = arrPicker[row]
        }
        
    }
}
