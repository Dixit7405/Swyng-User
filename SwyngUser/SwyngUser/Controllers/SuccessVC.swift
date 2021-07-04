//
//  SuccessVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 01/07/21.
//

import UIKit

protocol SuccessDelegate:AnyObject {
    func didDismissSuccess()
}

class SuccessVC: UIViewController {

    weak var delegate:SuccessDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.dismiss(animated: true) {
                self.delegate?.didDismissSuccess()
            }
        }
        // Do any additional setup after loading the view.
    }

}
