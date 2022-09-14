//
//  ViewController.swift
//  Yelpy
//
//  Created by Angel Zambrano on 9/13/22.
//

import UIKit



class ViewController: UIViewController {
    
    let tableview: UITableView = {
        let tb = UITableView()
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tb.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
        tb.backgroundColor = .red
        return tb
    }()
    
    var businessArray: [Business] = [Business]()
    
    var restaurantsArray: [[String: Any?]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setUpViews()
        setUpAutoLayout()
        
        getAPIData()
        
        getData()
        
    }
    
    // converts the rating
    var ratingMap = [0.0: "regular_0", 1.0:"regular_1",1.5:"regular_1_half", 2.0 : "regular_2", 2.5: "regular_2_half", 3.0: "regular_3",3.5:"regular_3_half", 4.0:"regular_4", 4.5 :"regular_4_half", 5.0:"regular_5"]
    
    func getData() {
        API.fetchBusinesses { result in
            switch result {
            case .success(let businesses):
                self.updateUI(with: businesses)
                break
                
            case .failure(let error):
                print("there was an error")
//                self.displayError(error, title: "Failed to fetch movies")
                
            }
        }
    }
    
    private func updateUI(with businesses: [Business]) {
        DispatchQueue.main.async {
            self.businessArray = businesses

            self.tableview.reloadData()
        }
    }
    
    
    
    
    
    func getAPIData() {
        API.getRestaurants { restaurants in
            guard let restaurants = restaurants else {
                return
            }
            
                self.restaurantsArray = restaurants
                self.tableview.reloadData()
            
        }
    }
    
    func setUpViews(){
        
        view.addSubview(tableview)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }


}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessArray.count
    }
    
    
    func configure(_ cell: RestaurantTableViewCell, forItemAt indexPath: IndexPath)
    {
        let business = businessArray[indexPath.row]
        
        cell.phoneNumberLbl.text = business.displayPhone
        
       if let url = business.imageURL as String? {
           let imageUrl = URL(string: url)!
           API.fetchImage(url: imageUrl) { image in
               DispatchQueue.main.async {
                   cell.imageview.image = image
               }
               
           }
       }
        
        cell.reviewCount.text = String(business.rating)
        let imgName2 = business.rating as? Double ?? nil
        
        
        if let starviews = imgName2 {
            cell.stars.image = UIImage(named: ratingMap[starviews]!)
        }
        
        cell.title.text = business.name
        
        let categories = business.categories
        var strCategories = ""
        
        
        // TODO:
        print(categories)
        // appending string into
        for (i, cat) in categories.enumerated() {

                
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as! RestaurantTableViewCell
        
        
        
//        let restaurant = restaurantsArray[indexPath.row]
//
//
//
//        // TODO: clean up
//
//        // editing cell
//        if let imageUrlString = restaurant["image_url"] as? String {
//            // 2.
//            let imageUrl = URL(string: imageUrlString)!
//            // 3.
//            API.fetchImage(url: imageUrl) { img in
//
//                DispatchQueue.main.async {
//                cell.imageview.image  = img
//                }
//            }
//        }
//
//        cell.title.text = restaurant["name"] as? String ?? ""
//        cell.phoneNumberLbl.text = restaurant["display_phone"] as? String ?? ""
//        let reviewCount = restaurant["review_count"] as? Int
//
//        cell.rating.text = String(reviewCount!)
//
//        let imgName2 = restaurant["rating"] as? Double ?? nil
//        if let imgName2 = imgName2 {
//
//            cell.stars.image = UIImage(named: ratingMap[imgName2]!)
//
//        }
        
        configure(cell, forItemAt: indexPath)
            

        
      
        
        
        return cell
    }
}
