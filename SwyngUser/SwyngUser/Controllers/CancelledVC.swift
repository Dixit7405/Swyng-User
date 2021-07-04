//
//  CancelledVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 01/07/21.
//

import UIKit

protocol CancelledDelegate:AnyObject {
    func didDismissVC()
}

class CancelledVC: UIViewController {

    weak var delegate:CancelledDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.dismiss(animated: true) {
                self.delegate?.didDismissVC()
            }
        }
        // Do any additional setup after loading the view.
    }

}
