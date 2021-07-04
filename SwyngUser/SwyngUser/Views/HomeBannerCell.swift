//
//  HomeBannerCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 26/04/21.
//

import UIKit

class HomeBannerCell: UICollectionViewCell {
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblAddressTime:UILabel!
    @IBOutlet weak var lblOpenFor:UILabel!
    @IBOutlet weak var imgTournament:UIImageView!
    
    var categories:[TournamentsType] = []
    var runsCategories:[RunsCategory] = []
    var tournament:Tournaments?{
        didSet{
            lblName.text = tournament?.tournamentName
            let startDate = tournament?.dates?.first?.toCustomDate(.withDay) ?? ""
            lblAddressTime.text = startDate + " " + (tournament?.venueAddress ?? "")
            let openFor = categories.filter({tournament?.categoryId?.contains(($0.tournamentCategoryId ?? 0).toString()) ?? false})
            lblOpenFor.text = openFor.compactMap({$0.name}).joined(separator: ", ")
            
            imgTournament.setImage(from: ImageBase.imagePath + (tournament?.thumbnailImage ?? ""))
        }
    }
    
    var runs:Run?{
        didSet{
            lblName.text = runs?.runName
            let startDate = runs?.dates?.first?.toCustomDate(.withDay) ?? ""
                lblAddressTime.text = startDate + " " + (runs?.venueAddress ?? "")
            let openFor = runsCategories.filter({runs?.category?.contains(($0.runCategoriesId ?? 0)) ?? false})
            lblOpenFor.text = openFor.compactMap({$0.name}).joined(separator: ", ")
            imgTournament.setImage(from: ImageBase.imagePath + (runs?.thumbnailImage ?? ""))
        }
    }
}
