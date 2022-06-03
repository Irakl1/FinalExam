//
//  Payment.swift
//  FinalExam
//
//  Created by Irakli Karanadze on 31.05.22.
//

import UIKit

class Payment: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data : [Technic] = []
    var total : Int = 0
    var counts: [String: Int] = [:]
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var delivery: UILabel!
    @IBOutlet weak var TOTAL: UILabel!
    @IBOutlet weak var payment: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as! PaymentCell
        let name = Array(counts.keys)[indexPath.row]
        let amount = String(counts[name]!)
        let price = self.data.filter { $0.title == name }
        cell.nameLBL.text = name
        cell.amountLBL.text = amount + "X"
        cell.totalPRiceLBL.text = String(Int(amount)! * price[0].price ) + "$"
        if let imageUrl = URL(string: price[0].thumbnail ) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl)
                if let data = data {
                    let image = UIImage (data: data)
                    DispatchQueue.main.async {
                        cell.imageLBL.image = image
                   }
                }
            }
        }
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        payment.delegate = self
        payment.dataSource = self
        extractData()
        payment.reloadData()
        calculatTotalPrice()
    }
    
    @IBAction func payForAll(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if self.total + self.total * 10/100 + 50 > 5000 {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FailViewController") as! FailViewController
            self.present(nextViewController, animated: true)
        }else {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SucssesViewController") as! SucssesViewController
            self.present(nextViewController, animated: true)
        }
        
    }
    
    func extractData() {
        for product in data {
            counts[product.title] = (counts[product.title] ?? 0) + 1
        }
        print(counts)
    }
    func calculatTotalPrice() {
        self.totalPrice.text = String(self.total) + "$"
        self.fee.text = String(self.total * 10/100 ) + "$"
        self.TOTAL.text = String(self.total + self.total * 10/100 + 50) + "$"
    }
    
}
