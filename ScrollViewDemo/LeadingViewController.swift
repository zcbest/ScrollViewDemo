//
//  ViewController.swift
//  ScrollViewDemo
//
//  Created by 曾超 on 16/1/16.
//  Copyright © 2016年 zengchao. All rights reserved.
//

import UIKit

class LeadingViewController: UIViewController, UIScrollViewDelegate {

    let width = UIScreen.mainScreen().bounds.width
    let height = UIScreen.mainScreen().bounds.height

    var scrollView = UIScrollView()
    //父视图是self.view
    var pageControl = UIPageControl()
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载scrollView视图
        loadScrollView()
        
        //加载pageControl
        loadPageControl()
    }

    func loadScrollView() {
        self.scrollView = UIScrollView(frame: CGRectMake(0,0,self.width,self.height))
        self.scrollView.contentSize = CGSize(width: CGFloat(4) * self.width, height: self.height)
        self.scrollView.pagingEnabled = true
        //bounces默认为true，如果为true在第一页和最后一页还是可以滑动的
        self.scrollView.bounces = false
        //scrollView的水平显示器
        self.scrollView.showsHorizontalScrollIndicator = false
        //设置代理
        self.scrollView.delegate = self
        
        self.view.addSubview(self.scrollView)
        
        for i in 1...4{
            let imageView = UIImageView(image: UIImage(named: "\(i + 1).png"))
            //图片的起点从原点(0，0)开始
            imageView.frame = CGRectMake(CGFloat(i - 1)*self.width, 0, self.width, self.height)
            
            self.scrollView.addSubview(imageView)
        }
        
    }
    
    func loadPageControl(){
        self.pageControl.center = CGPoint(x: self.width / 2, y: self.height - 30)
        self.pageControl.numberOfPages = 4
        self.pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        self.pageControl.pageIndicatorTintColor = UIColor.yellowColor()
        self.view.addSubview(self.pageControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //#MARK: --UIScrollViewDelegate的代理方法
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / self.width)
        self.pageControl.currentPage = index
        
        if index == 3{
            self.button.frame = CGRectMake(CGFloat(3) * self.width, self.height, self.width, 50)
            self.button.setTitle("走进Swift", forState: UIControlState.Normal)
            self.button.backgroundColor = UIColor.orangeColor()
            //不显示
            self.button.alpha = 0
            
            self.scrollView.addSubview(self.button)
            //UIView的动画效果
            UIView.animateWithDuration(1.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.button.alpha = 1
                self.button.frame = CGRectMake(CGFloat(3) * self.width, self.height - 100, self.width, 50)
                }, completion: nil)
            
            self.button.addTarget(self, action: "toMainViewController", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func toMainViewController(){
        presentViewController(MainViewController(), animated: true, completion: nil)
    }
}

