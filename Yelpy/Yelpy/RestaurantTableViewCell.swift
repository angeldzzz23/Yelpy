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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpLayout()
        setUpConstraints()
        
        print(contentView.bounds.height)
    }
    
    
   private func setUpLayout() {
        
        contentView.addSubview(imageview)
    }
   private func setUpConstraints() {
       
       NSLayoutConstraint.activate([
       
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
