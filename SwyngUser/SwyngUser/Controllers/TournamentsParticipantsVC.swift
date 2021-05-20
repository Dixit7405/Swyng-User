//
//  TournamentsParticipantsVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 12/05/21.
//

import UIKit

class TournamentsParticipantsVC: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var btnMensOpen:UIButton!
    @IBOutlet weak var btnWomensOpen:UIButton!
    @IBOutlet weak var btnMixedOpen:UIButton!
    enum SelectedTournaments {
        case mens
        case woments
        case mixed
    }
    
    var selected:SelectedTournaments = .mens
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMensOpen(btnMensOpen)
        // Do any additional setup after loading the view.
    }
}

//MARK: - ACTION METHODS
extension TournamentsParticipantsVC{
    @IBAction func btnMensOpen(_ sender:UIButton){
        selected = .mens
        sender.setSelected(selected:true)
        btnMixedOpen.setSelected(selected: false)
        btnWomensOpen.setSelected(selected: false)
        tableView.reloadData()
    }
    
    @IBAction func btnWomensOpen(_ sender:UIButton){
        selected = .woments
        sender.setSelected(selected:true)
        btnMixedOpen.setSelected(selected: false)
        btnMensOpen.setSelected(selected: false)
        tableView.reloadData()
    }
    
    @IBAction func btnMixedOpen(_ sender:UIButton){
        selected = .mixed
        sender.setSelected(selected:true)
        btnMensOpen.setSelected(selected: false)
        btnWomensOpen.setSelected(selected: false)
        tableView.reloadData()
    }
}

//MARK: - TABLEVIEW DELEGATE
extension TournamentsParticipantsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath) as! ParticipantCell
        cell.viewParticipant2.isHidden = selected != .mixed
        cell.lblIndex.text = "\(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


