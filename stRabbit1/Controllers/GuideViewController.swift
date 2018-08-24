//
//  GuideViewController.swift
//  1MemorySprite
//
//  Created by sj on 15/01/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {


    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startBtn: UIButton!
    private var scrollView: UIScrollView!

    private let numberOfPages = 3
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = self.view.bounds
        
        scrollView = UIScrollView(frame: frame)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPoint.zero
        scrollView.contentSize = CGSize(width: frame.width * CGFloat(numberOfPages), height: frame.height)
        scrollView.delegate = self
        
        for i in 0..<numberOfPages {
            let imageView = UIImageView(image: UIImage(named: "GuideImage\(i)"))
            imageView.frame = CGRect(x: frame.width * CGFloat(i), y: 0, width: frame.width, height: frame.height)
            scrollView.addSubview(imageView)
        }
        
        startBtn.alpha = 0.0
        self.view.insertSubview(scrollView, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func enterGame(_ sender: Any) {
        performSegue(withIdentifier: "guideToLogin", sender: self)
    }


}


extension GuideViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        
        if pageControl.currentPage == numberOfPages - 1 {
            UIView.animate(withDuration: 1.0, animations: {
                self.startBtn.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 1.0, animations: {
                self.startBtn.alpha = 0.0
            })
        }
    }
}
