//
//  TournamentGridCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 09/05/21.
//

import UIKit

protocol TournamentGridDelegate:AnyObject {
    func didTapRegister(tournament:Tournaments?)
    func didTapDetails(tournament:Tournaments?)
    func didTapRegister(run:Run?)
    func didTapDetails(run:Run?)
}

class TournamentGridCell: UICollectionViewCell {
    @IBOutlet weak var lblCategory:UILabel!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblAddressTime:UILabel!
    @IBOutlet weak var lblOpenFor:UILabel!
    @IBOutlet weak var lblRegisterBefore:UILabel!
    @IBOutlet weak var lblPlayerCount:UILabel!
    @IBOutlet weak var imgTournament:UIImageView!
    @IBOutlet weak var viewButtons:UIView!
    @IBOutlet weak var btnFavorite:UIButton!
    weak var delegate:TournamentGridDelegate?
    
    var categories:[TournamentsType] = []
    var runsCategories:[RunsCategory] = []
    var tournament:Tournaments?{
        didSet{
            lblCategory.text = "Tournament"
            lblName.text = tournament?.tournamentName
            let startDate = tournament?.dates?.first?.toCustomDate(.withDay) ?? ""
            lblAddressTime.text = startDate + " " + (tournament?.venueAddress ?? "")
            let openFor = categories.filter({tournament?.categoryId?.contains(($0.tournamentCategoryId ?? 0).toString()) ?? false})
            lblOpenFor.text = openFor.compactMap({$0.name}).joined(separator: ", ")
            lblRegisterBefore.text = "Register before \(tournament?.registerBeforeFromStartTime ?? "")"
            lblPlayerCount.text = "\(tournament?.noOfPlayers ?? 0) players have registerd"
            imgTournament.setImage(from: ImageBase.imagePath + (tournament?.thumbnailImage ?? ""))
        }
    }
    
    var runs:Run?{
        didSet{
            lblCategory.text = "Runs"
            lblName.text = runs?.runName
            let startDate = runs?.dates?.first?.toCustomDate(.withDay) ?? ""
                lblAddressTime.text = startDate + " " + (runs?.venueAddress ?? "")
            let openFor = runsCategories.filter({runs?.category?.contains(($0.runCategoriesId ?? 0)) ?? false})
            lblOpenFor.text = openFor.compactMap({$0.name}).joined(separator: ", ")
            lblRegisterBefore.text = "Register before \(runs?.registerBeforeFromStartTime ?? "")"
            lblPlayerCount.text = "\(0) players have registerd"
            imgTournament.setImage(from: ImageBase.imagePath + (runs?.thumbnailImage ?? ""))
        }
    }
    
    @IBAction func btnRegisterTapped(_ sender:UIButton){
        if ApplicationManager.sportType == .tournaments{
            delegate?.didTapRegister(tournament: tournament)
        }
        else{
            delegate?.didTapRegister(run: runs)
        }
    }
    
    @IBAction func btnDetailsTapped(_ sender:UIButton){
        if ApplicationManager.sportType == .tournaments{
            delegate?.didTapDetails(tournament: tournament)
        }
        else{
            delegate?.didTapDetails(run: runs)
        }
    }
    
    @IBAction func btnSharePressed(_ sender:UIButton){
        var text = ""
        guard let url = URL(string: AppDetails.appURL) else {return}
        if ApplicationManager.sportType == .tournaments{
            text = "Checkout swyng application for new tournament \(tournament?.tournamentName ?? ""), on \(tournament?.dates?.first?.toCustomDate(.withDay) ?? "") at \(tournament?.venueAddress ?? "")"
        }
        else{
            text = "Checkout swyng application for new run \(runs?.runName ?? ""), on \(runs?.dates?.first?.toCustomDate(.withDay) ?? "") at \(runs?.venueAddress ?? "")"
        }
        let textShare = [ text , url] as [Any]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self
        if let controller = AppUtilities.getMainWindow()?.rootViewController{
            controller.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnFavoritePressed(_ sender:UIButton){
        ApplicationManager.sportType == .tournaments ? addToFavorite(favorite: !sender.isSelected) : addToFavoriteRuns(favorite: !sender.isSelected)
    }
}

//MARK: - API SERVICES
extension TournamentGridCell{
    private func addToFavorite(favorite:Bool){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.tournament_id:tournament?.tournamentId ?? "",
                                   Parameters.favourite:favorite]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.favorite, type: CommonResponse<Favorite>.self) { response, status in
            
        } success: { success in
            self.btnFavorite.isSelected = favorite
        }

    }
    
    private func addToFavoriteRuns(favorite:Bool){
        let params:[String:Any] = [Parameters.token:ApplicationManager.authToken ?? "",
                                   Parameters.run_id:runs?.id ?? "",
                                   Parameters.favourite:favorite]
        Webservices().request(with: params, method: .post, endPoint: EndPoints.favoriteRuns, type: CommonResponse<Favorite>.self) { response, status in
            
        } success: { success in
            self.btnFavorite.isSelected = favorite
        }

    }
}
