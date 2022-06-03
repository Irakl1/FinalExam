//
//  PaymentCell.swift
//  FinalExam
//
//  Created by Irakli Karanadze on 31.05.22.
//

import UIKit

class PaymentCell: UITableViewCell {

    @IBOutlet weak var imageLBL: UIImageView!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var amountLBL: UILabel!
    @IBOutlet weak var totalPRiceLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
