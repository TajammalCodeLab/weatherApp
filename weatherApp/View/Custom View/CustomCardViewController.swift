//
//  CustomCardViewController.swift
//  weatherApp
//
//  Created by SID on 23/09/2024.
//

import UIKit

struct CustomCardViewController {
    
    static func shadowadding(cardView: UIView) {
        cardView.layer.cornerRadius = 8
        cardView.layer.shadowOpacity = 1
        cardView.backgroundColor = UIColor(red: 0, green: 0.1843, blue: 0.2784, alpha: 1.0)
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        cardView.layer.shadowPath = UIBezierPath(roundedRect: cardView.bounds, cornerRadius: cardView.layer.cornerRadius).cgPath
    }
}
