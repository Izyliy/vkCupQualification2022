//
//  CategoryCollectionViewCell.swift
//  vkCup
//
//  Created by iMac iOS Павел on 08.12.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    var tapCallback: ((Int) -> Void)?

    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(white: 1, alpha: 0.9)
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(systemName: "plus")
        view.tintColor = UIColor(white: 1, alpha: 0.9)
        
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.27)
        
        return view
    }()
    
    var id: Int = 0

    func configure(with category: Category) {
        self.id = category.id
        self.titleLabel.text = category.title
        
        setVisuals()
        setChecked(category.checked)
    }

    func cellTapped() {
        tapCallback?(id)
    }
    
    private func setVisuals() {
        backgroundColor = UIColor(white: 1, alpha: 0.17)
        layer.cornerRadius = 12
        
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(lineView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            lineView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 14),
            lineView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 20),
            lineView.widthAnchor.constraint(equalToConstant: 1),
            
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -11),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -11),
            imageView.leftAnchor.constraint(equalTo: lineView.rightAnchor, constant: 11),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setChecked(_ checked: Bool) {
        backgroundColor = checked ? UIColor(red: 1, green: 0.33, blue: 0.09, alpha: 1) : UIColor(white: 1, alpha: 0.17)
        imageView.image = checked ? UIImage(systemName: "checkmark") : UIImage(systemName: "plus")
        lineView.isHidden = checked ? true : false
    }
}
