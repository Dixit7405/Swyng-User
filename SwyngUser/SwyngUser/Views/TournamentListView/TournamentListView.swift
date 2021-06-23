//
//  TournamentListView.swift
//  Swyng
//
//  Created by Dixit Rathod on 22/05/21.
//

import Foundation
import UIKit

class TournamentListView:UIView{
    @IBOutlet var view:UIView!
    @IBOutlet weak var lblDateTime:UILabel!
    @IBOutlet weak var lblTournamentName:UILabel!
    @IBOutlet weak var lblAddress:UILabel!
    @IBOutlet weak var lblOpenFor:UILabel!
    
    var categories:[TournamentsType] = []
    var runsCategories:[RunsCategory] = []
    var tournament:Tournaments?{
        didSet{
            lblDateTime.text = tournament?.dates?.first?.toCustomDate(.dayWithNextLine)
            lblTournamentName.text = tournament?.tournamentName
            lblAddress.text = tournament?.venue
            
            let openFor = categories.filter({tournament?.categoryId?.contains(($0.tournamentCategoryId ?? 0).toString()) ?? false})
            lblOpenFor.text = openFor.compactMap({$0.name}).joined(separator: ", ")
        }
    }
    
    var runs:Run?{
        didSet{
            lblDateTime.text = runs?.dates?.first?.toCustomDate(.dayWithNextLine)
            lblTournamentName.text = runs?.runName
            lblAddress.text = runs?.venueAddress
            
            let openFor = runsCategories.filter({runs?.category?.contains(($0.runCategoriesId ?? 0)) ?? false})
            lblOpenFor.text = openFor.compactMap({$0.name}).joined(separator: ", ")
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed(String(describing: TournamentListView.self), owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
    }
}
