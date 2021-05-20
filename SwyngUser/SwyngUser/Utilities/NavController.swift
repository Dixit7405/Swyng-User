//
//  NavController.swift
//  MyTremolo Teacher
//
//  Created by Dixit Rathod on 14/10/20.
//

import Foundation
import UIKit

class NavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationBar.tintColor = UIColor.black
//        self.navigationBar.backIndicatorImage = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
//        self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
}
