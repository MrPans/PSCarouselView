//
//  SwiftViewController.swift
//  CarouselDemo
//
//  Created by Pan on 16/4/18.
//  Copyright © 2016年 Pan. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.mainScreen().bounds.size.width

class SwiftViewController: UIViewController {
    var carouselView: PSCarouselView = PSCarouselView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setupCarouselView()
        view.addSubview(carouselView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        carouselView.startMoving()
    }
    
    func setupCarouselView() {
        carouselView.frame =  CGRectMake(0,64,ScreenWidth,0.382 * ScreenWidth)
        carouselView.imageURLs = [IMAGE_URLSTRING0,IMAGE_URLSTRING1,IMAGE_URLSTRING2]
        carouselView.placeholder = UIImage(named: "placeholder")
        carouselView.autoMoving = true
    }
    
}
