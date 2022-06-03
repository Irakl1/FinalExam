//
//  MyCell.swift
//  FinalExam
//
//  Created by Irakli Karanadze on 23.05.22.
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var stockLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var countTextBox: UILabel!

    private var model:Technic? = nil
    private var plusAmount: ((_ count:Int) -> ())? = nil
    private var minusAmount: ((_ count:Int) -> ())? = nil

    func setProduct(model:Technic,plusAmount:((_ count:Int) -> ())? = nil, minusAmount: ((_ count:Int) -> ())? = nil){
        self.model = model
        self.plusAmount = plusAmount
        self.minusAmount = minusAmount

        nameLbl.text = self.model?.brand ?? ""
        priceLbl.text = String(self.model?.price ?? 0)
        stockLbl.text = String(self.model?.stock ?? 0)
        countTextBox.text = "\(self.model?.count ?? 0)"
        if let imageUrl = URL(string: self.model?.thumbnail ?? "") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl)
                if let data = data {
                    let image = UIImage (data: data)
                    DispatchQueue.main.async {
                        self.imgView.image = image
                   }
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func minusPrice(_ sender: Any) {
        if let count = model?.count {
            if count != 0 {
                let currentCount = count - 1
                updateCount(_ : currentCount)
                (minusAmount)?(currentCount)
            }
        }
    }
    @IBAction func plusPrice(_ sender: Any) {
        if let count = model?.count {
            let currentCount = count + 1
            updateCount(_ : currentCount)
            (plusAmount)?(currentCount)
        }
    }
        
    private func updateCount(_ currentCount:Int){
            countTextBox.text = "\(currentCount)"
            model?.count = currentCount
    }
}

