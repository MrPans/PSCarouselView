//
//  SwiftViewController.swift
//  CarouselDemo
//
//  Created by Pan on 16/4/18.
//  Copyright © 2016年 Pan. All rights reserved.
//

import UIKit
import PSCarouselView

let IMAGE_URLSTRING0 = "http://img.hb.aicdn.com/0f14ad30f6c0b4e4cf96afcad7a0f9d6332e5b061b5f3c-uSUEUC_fw658"
let IMAGE_URLSTRING1 = "http://img.hb.aicdn.com/3f9d1434ba618579d50ae8c8476087f1a04d7ee3169f8e-zD2u09_fw658"
let IMAGE_URLSTRING2 = "http://img.hb.aicdn.com/81427fb53bed38bf1b6a0c5da1c5d5a485e00bd1149232-gn4CO1_fw658"

let ScreenWidth = UIScreen.main.bounds.size.width

class SwiftViewController: UIViewController {
    var carouselView: PSCarouselView = PSCarouselView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setupCarouselView()
        view.addSubview(carouselView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        carouselView.startMoving()
    }
    
    func setupCarouselView() {
        carouselView.frame =  CGRect(x: 0,y: 64,width: ScreenWidth,height: 0.382 * ScreenWidth)
        carouselView.imageURLs = [IMAGE_URLSTRING0,IMAGE_URLSTRING1,IMAGE_URLSTRING2]
        carouselView.placeholder = UIImage(named: "placeholder")
        carouselView.isAutoMoving = true
    }
    
}
