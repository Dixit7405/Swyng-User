//
//  BaseVC.swift
//  Swyng
//
//  Created by Dixit Rathod on 05/06/21.
//

import Foundation
import UIKit

class BaseVC:UIViewController{
    
    @IBOutlet weak var headerView:HeaderView!
    
    var sportType:SportType{
        get{
            return ApplicationManager.sportType ?? .tournaments
        }
    }
    
    var isTournament:Bool{
        get{
            return ApplicationManager.sportType == .tournaments
        }
    }
    
    var selectedTournament:Tournaments?{
        get{
            return ApplicationManager.tournament
        }
    }
    
    var selectedRun:Run?{
        get{
            return ApplicationManager.runs
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if headerView != nil{
            headerView.backBlock = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            headerView.menuBlock = { [weak self] in
                self?.btnMenuPressed(self?.headerView.btnMenu ?? UIButton())
            }
        }
    }
    
}
