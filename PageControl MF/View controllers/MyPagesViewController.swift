//
//  MyPagesViewController.swift
//  PageControl MF
//
//  Created by Jeroen Dunselman on 01/01/2017.
//  Copyright © 2017 Jeroen Dunselman. All rights reserved.
//

import UIKit

class MyPagesViewController : UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  
  let pages = ["PagesContentController1", "PagesContentController2"]
  
  let myPageIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    self.dataSource = self
    
  }
  override func viewDidAppear(_ animated: Bool) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PagesContentController2")
    setViewControllers([vc!], // Has to be a single item array, unless you're doing double sided stuff I believe
      direction: .forward,
      animated: true,
      completion: nil)
  }
  
//  ** UIPageViewControllerDataSource
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
//Simply setting the value of this property is not enough to ensure that the view controller is preserved and restored. All parent view controllers must also have a restoration identifier.

    if let identifier = viewController.restorationIdentifier {
      if let index = pages.index(of: identifier) {
        if index > 0 {
          return self.storyboard?.instantiateViewController(withIdentifier: pages[index-1])
        } else {
          return self.storyboard?.instantiateViewController(withIdentifier: pages[pages.count-1])
        }
      }
    }
    return nil
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {

    if let identifier = viewController.restorationIdentifier {
      if let index = pages.index(of: identifier) {
        if index < pages.count - 1 {
          return self.storyboard?.instantiateViewController(withIdentifier: pages[index+1])
        } else {
          return self.storyboard?.instantiateViewController(withIdentifier: pages[0])
        }
      }
    }
    return nil
  }
  //niet verplicht, maarrr
  // If nil, user gesture-driven navigation will be disabled.

  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return pages.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    if let identifier = viewControllers?.first?.restorationIdentifier {
      if let index = pages.index(of: identifier) {
        return index
      }
    }
    return 0
  }//   UIPageViewControllerDataSource  **
  
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    // get pageControl and scroll view from pvc view's subviews
    
        guard let pageControl = (view.subviews.filter{ $0 is UIPageControl }.first! as? UIPageControl)
      else {  return }
    let scrollView = view.subviews.filter{ $0 is UIScrollView }.first! as! UIScrollView
    // remove all constraint from view that are tied to pagecontrol
    let const = view.constraints.filter { $0.firstItem as? NSObject == pageControl || $0.secondItem as? NSObject == pageControl }
    view.removeConstraints(const)
    
    // customize pagecontrol
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    //
    let heightOfPageControl:CGFloat = 20
    pageControl.addConstraint(pageControl.heightAnchor.constraint(equalToConstant: heightOfPageControl))
    //    pageControl.backgroundColor = view.backgroundColor
    
    // create constraints for pagecontrol
    let leading = pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    let trailing = pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    //**
    let yPosOfPageControl:CGFloat = 120
    let bottom = pageControl.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant:yPosOfPageControl) // add to scrollview not view
    
    // pagecontrol constraint to view
    view.addConstraints([leading, trailing, bottom])
    view.bounds.origin.y -= pageControl.bounds.maxY
    //    ??************
    //    let pageControl = UIPageControl()
    pageControl.pageIndicatorTintColor = UIColor.blue
    pageControl.currentPageIndicatorTintColor = UIColor.red
    pageControl.backgroundColor = UIColor.white
    pageControl.numberOfPages = pages.count
    pageControl.center = self.view.center
    self.view.addSubview(pageControl)
    
    //    ???wat doet
    pageControl.layer.position.y = self.view.frame.height - 200;
    //    ******
    
    
    //    for view in view.subviews {            print(self.view.description)
    //      if view is UIScrollView {
    //        view.frame =  CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 100, height: 100))//UIScreen.main.bounds // Why? I don't know.
    //      }
    //      else if view is UIPageControl {
    //        view.backgroundColor = UIColor.purple
    //      }
    //    }
  }
}
