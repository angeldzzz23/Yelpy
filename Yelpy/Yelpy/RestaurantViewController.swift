//
//  RestaurantViewController.swift
//  Yelpy
//
//  Created by Angel Zambrano on 9/14/22.
//

import UIKit

class RestaurantViewController: UIViewController {
    // MARK: properties
    
    /// restaurant image
    let restImage: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .green
        lbl.text = "New York Pizza Kitchen"
        lbl.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
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
            titleLbl.centerYAnchor.constraint(equalTo: restImage.centerYAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: restImage.trailingAnchor, constant: -view.frame.width/2)
        ])
        // adding the title
    }
    

}
