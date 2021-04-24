//
//  FirstNameVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 24/04/21.
//

import UIKit

class FirstNameVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnNextPressed(_ sender:UIButton){
        
        performSegue(withIdentifier: "LastNameSegue", sender: nil)
    }

}
