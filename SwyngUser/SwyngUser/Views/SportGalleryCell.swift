//
//  SportGalleryCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 05/05/21.
//

import UIKit

class SportGalleryCell: UICollectionViewCell {
    @IBOutlet weak var imgGallery:UIImageView!
    
    var tournamentImage:TournamentGallery?{
        didSet{
                imgGallery.setImage(from: ImageBase.commonPath + (tournamentImage?.image ?? ""))
        }
    }
}
