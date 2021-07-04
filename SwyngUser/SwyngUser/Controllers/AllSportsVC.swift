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

class AllSportsVC: BaseVC {
    @IBOutlet weak var tblAllSports:UITableView!
    @IBOutlet weak var tblSelectedCenters:UITableView!
    @IBOutlet weak var searchField:UITextField!
    @IBOutlet weak var nslcAllSportsHeight:NSLayoutConstraint!
    @IBOutlet weak var nslcSelectedTableHeight:NSLayoutConstraint!
    let disposeBag = DisposeBag()
    var arrAllCenters:[SportCenters] = []
    var arrSportCenters:[SportCenters] = []
    var filterSports:[Sports] = []
    var timer = Timer()
    var loadMore = false
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getAllSportCenters()
//        setupTableView()
        // Do any additional setup after loading the view.
    }
    

}

//MARK: - ACTION METHODS
extension AllSportsVC{
    @IBAction func btnLeftMenuPressed(_ sender:UIButton){
        self.leftBarPressed()
    }
    
    @IBAction func btnRightMenuPressed(_ sender:UIButton){
        rightBarPressed(forSportCenter: true)
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

//MARK: - FILTER DELEGATE
extension AllSportsVC{
    override func didApplyFilter(filter: Filter) {
        filterSports = filter.sport
        filterSportCenters()
    }
}

//MARK: - SEARCHBAR DELEGATE
extension AllSportsVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(searchSportCenter(timer:)), userInfo: updatedText, repeats: false)
        }
        
        return true
    }
    
    @objc func searchSportCenter(timer:Timer){
        if let text = timer.userInfo as? String{
            
            //check empty field for all data
            if text.trim() == ""{
                arrSportCenters = arrAllCenters
                tblAllSports.reloadData()
                return
            }
            searchSportCenter(text: text)
        }
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
        return arrSportCenters.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllSportsHeader", for: indexPath) as! AllSportsCell
            return cell
        }
        else{*/
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllSportsCell", for: indexPath) as! AllSportsCell
        cell.imgStar.isHidden = true
        cell.sportCenter = arrSportCenters[indexPath.row]
        return cell
//        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:SportsCenterDetailsVC = SportsCenterDetailsVC.controller()
        vc.centerId = arrSportCenters[indexPath.row].sportCenterId ?? 0
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - API SERVICES
extension AllSportsVC{
    private func getAllSportCenters(){
        startActivityIndicator()
//        let params:[String:Any] = [Parameters.offset:"",
//                                   Parameters.size:10,
//                                   Parameters.sport:filterSports.compactMap({$0.id}),
//                                   Parameters.location:[]]
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? ""]
        loadMore = false
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getSportCenters, type: CommonResponse<[SportCenters]>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            if let response = success as? CommonResponse<[SportCenters]>, let data = self.successBlock(response: response){
                self.loadMore = true
                self.arrAllCenters = data
                self.arrSportCenters = data
                self.tblAllSports.reloadData()
            }
        }
    }
    
    private func filterSportCenters(){
        startActivityIndicator()
        let params:[String:Any] = [Parameters.offset:0,
                                   Parameters.size:100,
                                   Parameters.sport:filterSports.compactMap({$0.id}),
                                   Parameters.location:[]]
        loadMore = false
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getSportCenterByFilter, type: CommonResponse<[SportCenters]>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            if let response = success as? CommonResponse<[SportCenters]>, let data = self.successBlock(response: response){
                self.loadMore = true
                self.arrAllCenters = data
                self.arrSportCenters = data
                self.tblAllSports.reloadData()
            }
        }
    }
    
    private func searchSportCenter(text:String){
        let params:[String:Any] = [Parameters.key:text]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.searchSportCenter, type: CommonResponse<[SportCenters]>.self, failer: failureBlock()) {[weak self] success in
            guard let self = self else {return}
            if let response = success as? CommonResponse<[SportCenters]>, let data = self.successBlock(response: response){
                self.arrSportCenters = data
                self.tblAllSports.reloadData()
            }
        }
    }
}

//MARK: - SCROLLVIEW DELEGATE
extension AllSportsVC{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.bounds.size.height) >= scrollView.contentSize.height, loadMore{
            offset += 10
            getAllSportCenters()
        }
    }
}
