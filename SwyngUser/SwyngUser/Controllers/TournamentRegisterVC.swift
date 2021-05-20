//
//  TournamentRegisterVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 11/05/21.
//

import UIKit

class TournamentRegisterVC: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var nslcTableHeight:NSLayoutConstraint!
    
    var selectedIndex:[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        // Do any additional setup after loading the view.
    }

}

//MARK: - TABLEVIEW DELEGATE
extension TournamentRegisterVC:UITableViewDelegate, UITableViewDataSource{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nslcTableHeight.constant = tableView.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TournamentRegisterCell", for: indexPath) as! TournamentRegisterCell
        cell.btnSelection.isSelected = selectedIndex.contains(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex.contains(indexPath.row){
            let index = selectedIndex.firstIndex(where: {$0 == indexPath.row}) ?? 0
            selectedIndex.remove(at: index)
        }
        else{
            selectedIndex.append(indexPath.row)
        }
        tableView.reloadData()
    }
}
