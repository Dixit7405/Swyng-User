//
//  EmailVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class EmailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBackPressed(_ sender:UIButton){
        dismiss(animated: true, completion: nil)
    }

    @IBAction func btnNextPressed(_ sender:UIButton){
        performSegue(withIdentifier: "GetStartedSegue", sender: nil)
    }

}
