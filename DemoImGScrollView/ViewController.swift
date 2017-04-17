//
//  ViewController.swift
//  DemoImGScrollView
//
//  Created by Balaji on 17/04/17.
//  Copyright © 2017 Raybiztech. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    var currentpage = 0
    @IBOutlet weak var imScrollView: UIScrollView!
    var ImViews = [UIImageView()]
    var imArray = ["one","two","three","four","five"]
    override func viewDidLoad() {
        super.viewDidLoad()
        imScrollView.delegate = self
        imScrollView.isPagingEnabled = true
        addSubview()
    }
    
    func addSubview(){
        for i in 0...1{
            let childScroll = UIScrollView()
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            childScroll.frame = CGRect(x: xPosition, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20)
            childScroll.delegate = self
            childScroll.minimumZoomScale = 1.0
            childScroll.maximumZoomScale = 3.0
            childScroll.tag = i
            let  imageView = UIImageView()
            imageView.frame = CGRect(x: 0, y: 0, width: childScroll.frame.width, height: childScroll.frame.height)
            imageView.image = UIImage(named:imArray[i])
            childScroll.addSubview(imageView)
            
            imScrollView.addSubview(childScroll)
        }
        imScrollView.contentSize.width = UIScreen.main.bounds.width*2
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if scrollView != imScrollView{
        var currentimg : UIView?
        for imView in  scrollView.subviews {
            if imView is UIImageView {
                if (scrollView.contentOffset.x >= imView.frame.origin.x) && (scrollView.contentOffset.x <= imView.frame.origin.x+UIScreen.main.bounds.width) {
                    currentimg = imView
                }
            }
        }
            return currentimg
        } else{
            return nil
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == imScrollView{
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            if currentpage != Int(pageNumber){
                for subViews in imScrollView.subviews{
                    if subViews.isKind(of: UIScrollView.self) {
                        if subViews.tag == currentpage{
                            if  let view:UIScrollView = subViews as? UIScrollView{
                                    //remove the zoom
                                view.contentOffset = CGPoint(x: 0, y: 0)
                                view.zoomScale = 0
                            }
                        }
                    }
                }
            }
            currentpage = Int(pageNumber)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

