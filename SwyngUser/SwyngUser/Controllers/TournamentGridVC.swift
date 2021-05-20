//
//  TournamentGridVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 09/05/21.
//

import UIKit

class TournamentGridVC: UIViewController {
    @IBOutlet weak var collectionView:UICollectionView!
    
    var tournaments:[Tournaments] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllTournaments()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

//MARK: - ACTION METHOD
extension TournamentGridVC{
    @IBAction func btnFilterPressed(_ sender:UIBarButtonItem){
        let vc:SportsFilterVC = SportsFilterVC.controller()
        
        self.presentFromLeft(vc)
    }
    
    @IBAction func btnMenuPressed(_ sender:UIBarButtonItem){
        self.leftBarPressed()
    }
        
}

//MARK: - COLLECTIONVIEW DELEGATE
extension TournamentGridVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tournaments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TournamentGridCell", for: indexPath) as! TournamentGridCell
        cell.tournament = tournaments[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}


//MARK: - API SERVICES
extension TournamentGridVC{
    private func getAllTournaments(){
        startActivityIndicator()
        Webservices().request(with: [:], method: .get, endPoint: EndPoints.getTournaments, type: CommonResponse<[Tournaments]>.self, failer: failureBlock()) {[weak self] (success) in
            guard let self = self else {return}
            guard let response = success as? CommonResponse<[Tournaments]> else {return}
            if let data = self.successBlock(response: response){
                self.tournaments = data
                self.collectionView.reloadData()
            }
        }
    }
}
