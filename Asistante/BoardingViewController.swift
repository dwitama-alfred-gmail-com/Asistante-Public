//
//  BoardingViewController.swift
//  Asistante
//
//  Created by Domenico Allegra on 31/03/20.
//  Copyright © 2020 com.tjakep. All rights reserved.
//

import UIKit

class BoardingViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var PageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0

    //data for the slides
    var boardingTitles = ["1","2","3"]
    var boardingDescs = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.","Lorem ipsum dolor sit amet, consectetur adipiscing elit.","Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
    var boardingImages = ["Image1","",""]

    //get dynamic width and height of scrollview and save it
    override func viewDidLayoutSubviews() {
        scrollWidth = ScrollView.frame.size.width
        scrollHeight = ScrollView.frame.size.height
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        //to call viewDidLayoutSubviews() and get dynamic width and height of scrollview

        self.ScrollView.delegate = self
        ScrollView.isPagingEnabled = true
        ScrollView.showsHorizontalScrollIndicator = false
        ScrollView.showsVerticalScrollIndicator = false

        //create the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        for index in 0..<boardingTitles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)

            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: boardingImages[index]))
            imageView.frame = CGRect(x:0,y:0,width:300,height:300)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
          
            let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+30,width:scrollWidth-64,height:30))
            txt1.textAlignment = .center
            txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
            txt1.text = boardingTitles[index]

            let txt2 = UILabel.init(frame: CGRect(x:32,y:txt1.frame.maxY+10,width:scrollWidth-64,height:50))
            txt2.textAlignment = .center
            txt2.numberOfLines = 3
            txt2.font = UIFont.systemFont(ofSize: 18.0)
            txt2.text = boardingDescs[index]

            slide.addSubview(imageView)
            slide.addSubview(txt1)
            slide.addSubview(txt2)
            ScrollView.addSubview(slide)

        // Do any additional setup after loading the view.
    }
        //set width of scrollview to accomodate all the slides
             ScrollView.contentSize = CGSize(width: scrollWidth * CGFloat(boardingTitles.count), height: scrollHeight)

             //disable vertical scroll/bounce
             self.ScrollView.contentSize.height = 1.0

             //initial state
             
            PageControl.numberOfPages = boardingTitles.count
            PageControl.currentPage = 0

         }
    //indicator
    @IBAction func pageChanged(_ sender: Any) {
        ScrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((PageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndicatorForCurrentPage()
    }

    func setIndicatorForCurrentPage()  {
        let page = (ScrollView?.contentOffset.x)!/scrollWidth
        PageControl?.currentPage = Int(page)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
