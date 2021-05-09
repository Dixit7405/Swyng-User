//
//  AllSportsVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 30/04/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class AllSportsVC: UIViewController {
    @IBOutlet weak var tblAllSports:UITableView!
    @IBOutlet weak var tblSelectedCenters:UITableView!
    @IBOutlet weak var searchField:UITextField!
    @IBOutlet weak var nslcAllSportsHeight:NSLayoutConstraint!
    @IBOutlet weak var nslcSelectedTableHeight:NSLayoutConstraint!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    

}

//MARK: - ACTION METHODS
extension AllSportsVC{
    @IBAction func btnLeftMenuPressed(_ sender:UIButton){
        self.leftBarPressed()
    }
    
    @IBAction func btnRightMenuPressed(_ sender:UIButton){
        let vc:SportsFilterVC = SportsFilterVC.controller()
        self.presentFromLeft(vc)
    }
}

//MARK: - CUSTOM METHODS
extension AllSportsVC{
    private func setupView(){
        tblAllSports.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
        tblSelectedCenters.addObserver(self, forKeyPath: #keyPath(UITableView.contentSize), options: .new, context: nil)
    }
    
    
    private func setupTableView(){
        let arr = Observable.just(["ab", "cd", "cd", "cd", "cd"])
        arr.bind(to: tblAllSports.rx.items(cellIdentifier: "AllSportsCell", cellType: AllSportsCell.self)){ index, model, cell in
            cell.imgStar.isHidden = true
            cell.layoutIfNeeded()
        }
        .disposed(by: disposeBag)
        tblAllSports.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

//MARK: - TABLEVIEW DELEGATES
extension AllSportsVC:UITableViewDelegate, UITableViewDataSource{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        nslcAllSportsHeight.constant = tblAllSports.contentSize.height + 10
        nslcSelectedTableHeight.constant = tblSelectedCenters.contentSize.height + 10
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllSportsHeader", for: indexPath) as! AllSportsCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllSportsCell", for: indexPath) as! AllSportsCell
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:SportsCenterDetailsVC = SportsCenterDetailsVC.controller()
        navigationController?.pushViewController(vc, animated: true)
    }
}
