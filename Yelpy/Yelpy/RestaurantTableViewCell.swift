//
//  RestaurantTableViewCell.swift
//  Yelpy
//
//  Created by Angel Zambrano on 9/13/22.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    static let identifier = "RestaurantTableViewCell"
    
    let imageview: UIImageView = {
        let imgview = UIImageView()
        imgview.backgroundColor = .green
        imgview.translatesAutoresizingMaskIntoConstraints = false
        return imgview
    }()
    
    var title: UILabel = {
        let lbl = UILabel()
        lbl.text = "Mythic Pizza"
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let typeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Pizza"
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let phoneNumberLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "(916) 642-0258"
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let stars: UIImageView = {
        let imgview = UIImageView()
        imgview.image = UIImage(named: "regular_0")
        imgview.contentMode = .scaleToFill
        imgview.translatesAutoresizingMaskIntoConstraints = false
        return imgview
    }()
    
    let rating: UILabel = {
        let lbl = UILabel()
        lbl.text = "425"
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .systemGray2
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpLayout()
        setUpConstraints()
        
        print(contentView.bounds.height)
    }
    
    
   private func setUpLayout() {
        
       contentView.addSubview(imageview)
       contentView.addSubview(title)
       contentView.addSubview(typeLbl)
       contentView.addSubview(stars)
       contentView.addSubview(rating)
       contentView.addSubview(phoneNumberLbl)
       
       
    }

    
   private func setUpConstraints() {
       let constant:CGFloat = 10
       
       NSLayoutConstraint.activate([
        imageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant),
        imageview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constant),
        imageview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant),
       ])
       
       imageview.widthAnchor.constraint(equalTo: imageview.heightAnchor, constant: 0).isActive = true
       
       
       NSLayoutConstraint.activate([
        title.topAnchor.constraint(equalTo: imageview.topAnchor,constant: 0),
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        title.trailingAnchor.constraint(equalTo: imageview.leadingAnchor, constant: -10)
       ])
        
       NSLayoutConstraint.activate([
        typeLbl.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
        typeLbl.leadingAnchor.constraint(equalTo: title.leadingAnchor),
        typeLbl.trailingAnchor.constraint(equalTo: title.trailingAnchor)
       ])
//
       NSLayoutConstraint.activate([
        stars.topAnchor.constraint(equalTo: typeLbl.bottomAnchor, constant: 10),
        stars.leadingAnchor.constraint(equalTo: typeLbl.leadingAnchor),
        
       ])
       let width: CGFloat = contentView.frame.width/3
       stars.widthAnchor.constraint(equalToConstant: width).isActive = true
       
       NSLayoutConstraint.activate([
        rating.centerYAnchor.constraint(equalTo: stars.centerYAnchor),
        rating.leadingAnchor.constraint(equalTo: stars.trailingAnchor, constant: 10)
       ])
       
       NSLayoutConstraint.activate([
        phoneNumberLbl.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 10),
        phoneNumberLbl.leadingAnchor.constraint(equalTo: stars.leadingAnchor)
        
       ])
       
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
