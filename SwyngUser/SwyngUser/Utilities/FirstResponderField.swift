//
//  FirstResponderField.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 29/04/21.
//

import UIKit

class FirstResponderField: CustomField {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.becomeFirstResponder()
    }

}
