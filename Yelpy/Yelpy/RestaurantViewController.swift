//
//  RestaurantViewController.swift
//  Yelpy
//
//  Created by Angel Zambrano on 9/14/22.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    // MARK: properties
    
    // converts the rating
    let ratingMap = [0.0: "regular_0", 1.0:"regular_1",1.5:"regular_1_half", 2.0 : "regular_2", 2.5: "regular_2_half", 3.0: "regular_3",3.5:"regular_3_half", 4.0:"regular_4", 4.5 :"regular_4_half", 5.0:"regular_5"]
    
    // MARK: initializers
    init(business: Business) {
        super.init(nibName: nil, bundle: nil)
        
        // updating view
        if let url = business.imageURL as String? {
            let imageUrl = URL(string: url)!
            API.fetchImage(url: imageUrl) { image in
                DispatchQueue.main.async {
                    self.restImage.image = image
                }

            }
        }
        
        // updating the name
        titleLbl.text = business.name
        
        // updating the stars
        let imgName2 = business.rating as? Double ?? nil


        if let starviews = imgName2 {
            starViewImg.image = UIImage(named: ratingMap[starviews]!)
        }
        
        reviewCount.text = String(business.rating)
        
        // updating the starcount
        
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// restaurant image
    let restImage: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "New York Pizza Kitchen"
        lbl.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    var starViewImg: UIImageView =  {
       let imgView = UIImageView()
        imgView.image = UIImage(named: "regular_5")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let reviewCount: UILabel = {
        let lbl = UILabel()
        lbl.text = "425"
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
        // Do any additional setup after loading the view.
    }
    
    
    private func addSubviews() {
        view.addSubview(restImage)
        restImage.addSubview(titleLbl)
        restImage.addSubview(starViewImg)
        restImage.addSubview(reviewCount)

    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            restImage.topAnchor.constraint(equalTo: view.topAnchor),
            restImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            restImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        restImage.heightAnchor.constraint(equalTo: restImage.widthAnchor, multiplier: 0.7).isActive = true
        
        // TODO:
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: restImage.leadingAnchor, constant: 10),
            titleLbl.centerYAnchor.constraint(equalTo: restImage.centerYAnchor, constant: 20),
            titleLbl.trailingAnchor.constraint(equalTo: restImage.trailingAnchor, constant: -10)
        ])
        
        
        // adding star img constraints
        let height: CGFloat = view.frame.width/3

        NSLayoutConstraint.activate([
            starViewImg.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10),
            starViewImg.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            starViewImg.widthAnchor.constraint(equalToConstant: height)
        
        ])
        
        NSLayoutConstraint.activate([
            reviewCount.leadingAnchor.constraint(equalTo: starViewImg.trailingAnchor, constant: 10),
            reviewCount.centerYAnchor.constraint(equalTo: starViewImg.centerYAnchor)
        ])

        
    }
    

}
