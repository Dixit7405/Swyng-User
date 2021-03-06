//
//  BookingReviewCell.swift
//  SwyngUser
//
//  Created by Dixit Rathod on 08/05/21.
//

import UIKit

class BookingReviewCell: UITableViewCell {
    @IBOutlet weak var btnClose:UIButton!
    @IBOutlet weak var lblCategoryName:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var stepperView:StepperView!
    
    var stepperUpdateBlock:((Int) -> Void)?
    
    var setSelected:Bool?{
        didSet{
            guard let selected = setSelected else {return}
            btnClose.isSelected = selected
        }
    }
    
    var ticket:CancelTicket?{
        didSet{
            guard let ticket = ticket else {return}
            lblCategoryName.text = ticket.category?.name
            lblPrice.text = String(format: "Rs. %@", ticket.category?.amount ?? "")
            if stepperView != nil{
                stepperView.stepperUpdateBlock = {[self] index in
                    if let stepper = stepperUpdateBlock{
                        stepper(index)
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
