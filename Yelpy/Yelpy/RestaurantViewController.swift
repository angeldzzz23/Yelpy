//
//  RestaurantViewController.swift
//  Yelpy
//
//  Created by Angel Zambrano on 9/14/22.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    // MARK: properties
    
    
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
        
//        .addSubview(titleLbl)
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
        
        
        // adding
        let height: CGFloat = view.frame.width/3

        NSLayoutConstraint.activate([
            starViewImg.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10),
            starViewImg.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            starViewImg.widthAnchor.constraint(equalToConstant: height)
        
        ])
        
    }
    

}
