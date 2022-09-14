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
    let ratingMap = [0.0: "regular_0", 1.0:"regular_1",1.5:"regular_1_half", 2.0 : "regular_2", 2.5: "regular_2_half", 3.0: "regular_3",3.5:"regular_3_half", 4.0:"regular_4", 4.5 :"regular_4_half", 5.0:"regular_5"]

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        navigationController?.present( RestaurantViewController(business: businessArray[indexPath.row]), animated: true)

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


        // TODO: Refactor this more

        // appending string into
        for (i, cat) in categories.enumerated() {
            if i == 0 && categories.count == 1 {
                strCategories += cat.title
            } else if i == 0 {
                strCategories += cat.title + ", "
            } else if i == categories.count - 1 {
                strCategories += cat.title
            }
        }

        cell.typeLbl.text = strCategories

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as! RestaurantTableViewCell

        configure(cell, forItemAt: indexPath)


        return cell
    }
}
