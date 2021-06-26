//
//  TournamentGalleryVC.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 12/05/21.
//

import UIKit

class TournamentGalleryVC: BaseVC {
    @IBOutlet weak var collectionView:UICollectionView!
    
    var arrImages:[TournamentGallery] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.layoutIfNeeded()
        isTournament ? getGalleryImages() : getRunsGalleryImages()
        
        // Do any additional setup after loading the view.
    }

}

//MARK: - COLLECTIONVIEW DELEGATES
extension TournamentGalleryVC:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportGalleryCell", for: indexPath) as! SportGalleryCell
        cell.tournamentImage = arrImages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width-40-15)/4
        return CGSize(width: width, height: width)
    }
}

//MARK: - API SERVICE
extension TournamentGalleryVC{
    private func getGalleryImages(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.tournament_id:ApplicationManager.tournament?.tournamentId ?? 0]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getTournamentGallery, type: CommonResponse<[TournamentGallery]>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<[TournamentGallery]> else {return}
            arrImages = response.data ?? []
            collectionView.reloadData()
        }
    }
    
    private func getRunsGalleryImages(){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.run_id:ApplicationManager.runs?.id ?? 0]
        startActivityIndicator()
        Webservices().request(with: params, method: .post, endPoint: EndPoints.getRunsGallery, type: CommonResponse<[TournamentGallery]>.self, failer: failureBlock()) {[self] success in
            stopActivityIndicator()
            guard let response = success as? CommonResponse<[TournamentGallery]> else {return}
            arrImages = response.data ?? []
            collectionView.reloadData()
        }
    }
}
