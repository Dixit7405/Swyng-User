//
//  TournamentCMSVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 12/05/21.
//

import UIKit

class TournamentCMSVC: UIViewController {
    @IBOutlet weak var lblTitle:UILabel!
    
    var pageTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = pageTitle
        // Do any additional setup after loading the view.
    }
}
