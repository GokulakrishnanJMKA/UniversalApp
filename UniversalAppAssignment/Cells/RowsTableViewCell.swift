//
//  RowsTableViewCell.swift
//  UniversalAppAssignment
//
//  Created by apple on 07/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class RowsTableViewCell: UITableViewCell {

    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let stackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 8
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackView
    }()
    
    let ImgVwRows:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
        return img
    }()
    
    let lblTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lblDescription:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.textColor =  .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(ImgVwRows)
        containerView.addSubview(stackView)
        self.contentView.addSubview(containerView)
        
        ImgVwRows.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        ImgVwRows.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        ImgVwRows.widthAnchor.constraint(equalToConstant:40).isActive = true
        ImgVwRows.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.ImgVwRows.trailingAnchor, constant:10).isActive = true
        
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        
        stackView.addArrangedSubview(lblTitle)
        stackView.addArrangedSubview(lblDescription)
        
        lblTitle.setContentHuggingPriority(UILayoutPriority.defaultLow, for:.vertical)
        lblDescription.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.vertical)
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
