//
//  MainStoryboardViewController.swift
//  FinalExam
//
//  Created by Irakli Karanadze on 27.05.22.
//

import UIKit

class MainStoryboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet weak var calculatedPrice: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var technicTableView: UITableView!
    
    private let technicPicture = URL(string: "https://dummyjson.com/products")!
    private var technics = [Technic]()
    private var productItems:[ItemCategory] = []
    
    var totalPrice = 0
    var totalTechnic = 0
    var cart = [Technic]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productItems[section].producst.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return productItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.productItems[section].categoryTitle
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = productItems[indexPath.section].producst[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.setProduct(model: model) { count in
            self.updateTotalPrise(section: indexPath.section, index: indexPath.row,count:count,isMinus:false)
            self.cart.append(model)
        } minusAmount: { count in
            self.updateTotalPrise(section: indexPath.section, index: indexPath.row,count:count,isMinus:true)
            var someArray = self.cart.filter {
             return   $0.id == model.id
            }
            someArray.remove(at: 0)
            self.cart = self.cart.filter {
             return   $0.id != model.id
            }
            self.cart = someArray + self.cart
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        technicTableView.delegate = self
        technicTableView.dataSource = self
        downloadJason()
        technicTableView.reloadData()

    }
    
    private func updateTotalPrise(section:Int, index:Int,count:Int, isMinus:Bool){
        self.productItems[section].producst[index].count = count
        let price = self.productItems[section].producst[index].price
        if isMinus {
            totalTechnic -= 1
            totalPrice -= price
        }else {
            totalTechnic += 1
            totalPrice += price
        }
        calculatedPrice.text = "\(totalPrice) $"
        amountLbl.text = "\(totalTechnic)"
    }
   
    func extractCategorys() {
      var categorys = [String]()
        for product in self.technics {
            categorys.append(product.category.capitalized)
        }
        categorys = Array(Set(categorys))
        
        for category in categorys {
            let technics = self.technics.filter {
                $0.category.capitalized == category
            }
            var model = ItemCategory()
            model.producst = technics
            model.categoryTitle = category
            productItems.append(model)
        }
    }

    func downloadJason () {
        URLSession.shared.dataTask(with: technicPicture) { data, URLResponse, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            do {
            let decoder = JSONDecoder()
            guard let deocdedData = try? decoder.decode(TechnicRequest.self, from: data) else {
                return
            }
            self.technics = deocdedData.products
            self.extractCategorys()
            DispatchQueue.main.async {
                self.technicTableView.reloadData()
            }
        }
    }.resume()
}
    
    @IBAction func navigateToPayment(_ sender: UIButton) {
        if totalTechnic > 0 && totalPrice > 0 {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Payment") as! Payment
            nextViewController.data = self.cart
            nextViewController.total = self.totalPrice
            self.show(nextViewController, sender: self)
        }
    }
    
}
