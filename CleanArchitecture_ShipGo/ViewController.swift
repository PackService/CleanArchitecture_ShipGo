//
//  ViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .orange
        
        // MARK: - 폰트 확인용
        for family in UIFont.familyNames {
            print(family)
            
            for sub in UIFont.fontNames(forFamilyName: family) {
                print("====> \(sub)")
            }
        }
    }


}

