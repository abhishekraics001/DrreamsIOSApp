//
//  CourseVC.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 05/01/23.
//

import UIKit

class CourseVC: UIViewController {
    @IBOutlet var tabsView: TabsView!
    @IBOutlet var filterBtn: CustomButton!
    @IBOutlet var cartBtn: CustomButton!
    @IBOutlet var headerView: UIView!
    
    var currentIndex: Int = 0
    let gradientLayer = CAGradientLayer()
    var pageController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterBtn.imageTintColor = UIImage(named: "filter-2-fill")?.withTintColor(.white)
        
        setupTabs()
        setupPageViewController()
        
        headerView.backgroundColor = .black
        headerView.layer.cornerRadius = 25
        gradientLayer.cornerRadius = 25
        gradientLayer.frame = headerView.bounds
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.blue.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.headerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    func setupPageViewController() {
        // PageViewController
        self.pageController = storyboard?.instantiateViewController(withIdentifier: "TabsPageViewController") as! TabsPageViewController
        self.addChild(self.pageController)
        self.view.addSubview(self.pageController.view)
        
        // Set PageViewController Delegate & DataSource
        pageController.delegate = self
        pageController.dataSource = self
        
        // Set the selected ViewController in the PageViewController when the app starts
        pageController.setViewControllers([showViewController(0)!], direction: .forward, animated: true, completion: nil)
        
        // PageViewController Constraints
        self.pageController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.pageController.view.topAnchor.constraint(equalTo: self.tabsView.bottomAnchor),
            self.pageController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.pageController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.pageController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.pageController.didMove(toParent: self)
    }
    func setupTabs() {
        // Add Tabs (Set 'icon'to nil if you don't want to have icons)
        tabsView.tabs = [
            Tab(icon: UIImage(named: "music"), title: "All"),
            Tab(icon: UIImage(named: "movies"), title: "Radiology"),
            //                Tab(icon: UIImage(named: "books"), title: "Books")
        ]
        
        // Set TabMode to '.fixed' for stretched tabs in full width of screen or '.scrollable' for scrolling to see all tabs
        tabsView.tabMode = .fixed
        
        // TabView Customization
        tabsView.titleColor = .white
        tabsView.iconColor = .white
        tabsView.indicatorColor = #colorLiteral(red: 0.893999815, green: 0.893999815, blue: 0.893999815, alpha: 0.2494308775)
        tabsView.titleFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
        tabsView.collectionView.backgroundColor = .clear
        
        // Set TabsView Delegate
        tabsView.delegate = self
        
        // Set the selected Tab when the app starts
        tabsView.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Refresh CollectionView Layout when you rotate the device
        tabsView.collectionView.collectionViewLayout.invalidateLayout()
    }
    @IBAction func filterAction(_ sender:UIButton){
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let vc:FilterVC = storyboard.instantiateViewController(identifier: "FilterVC")
        self.navigationController?.present(vc, animated: true)
    }
    @IBAction func cartAction(_ sender:UIButton){
//        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CartVC") as! UINavigationController
//        navigationController?.pushViewController(vc, animated: true)
        view.insertSubview(vc.view, at: 4)
        addChild(vc)
        vc.didMove(toParent: self)
//        let vc:CartVC = storyboard.instantiateViewController(identifier: "CartVC")
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension CourseVC: TabsDelegate {
    func tabsViewDidSelectItemAt(position: Int) {
        // Check if the selected tab cell position is the same with the current position in pageController, if not, then go forward or backward
        if position != currentIndex {
            if position > currentIndex {
                self.pageController.setViewControllers([showViewController(position)!], direction: .forward, animated: true, completion: nil)
            } else {
                self.pageController.setViewControllers([showViewController(position)!], direction: .reverse, animated: true, completion: nil)
            }
            tabsView.collectionView.scrollToItem(at: IndexPath(item: position, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
extension CourseVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    // return ViewController when go forward
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = pageViewController.viewControllers?.first
        var index: Int
        index = getVCPageIndex(vc)
        // Don't do anything when viewpager reach the number of tabs
        if index == tabsView.tabs.count {
            return nil
        } else {
            index += 1
            return self.showViewController(index)
        }
    }
    
    // return ViewController when go backward
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = pageViewController.viewControllers?.first
        var index: Int
        index = getVCPageIndex(vc)
        
        if index == 0 {
            return nil
        } else {
            index -= 1
            return self.showViewController(index)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            if completed {
                guard let vc = pageViewController.viewControllers?.first else { return }
                let index: Int
                
                index = getVCPageIndex(vc)
                
                tabsView.collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredVertically)
                // Animate the tab in the TabsView to be centered when you are scrolling using .scrollable
                tabsView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    // Show ViewController for the current position
    func showViewController(_ index: Int) -> UIViewController? {
        if (self.tabsView.tabs.count == 0) || (index >= self.tabsView.tabs.count) {
            return nil
        }
        
        currentIndex = index
        
        if index == 0 {
            let contentVC = storyboard?.instantiateViewController(withIdentifier: "AllViewController") as! AllViewController
            contentVC.pageIndex = index
            return contentVC
        } else if index == 1 {
            let contentVC = storyboard?.instantiateViewController(withIdentifier: "RadiologyViewController") as! RadiologyViewController
            contentVC.pageIndex = index
            return contentVC
        } else {
            let contentVC = storyboard?.instantiateViewController(withIdentifier: "AllViewController") as! AllViewController
            contentVC.pageIndex = index
            return contentVC
        }
    }
    // Return the current position that is saved in the UIViewControllers we have in the UIPageViewController
    func getVCPageIndex(_ viewController: UIViewController?) -> Int {
        switch viewController {
        case is AllViewController:
            let vc = viewController as! AllViewController
            return vc.pageIndex
        case is RadiologyViewController:
            let vc = viewController as! RadiologyViewController
            return vc.pageIndex
        default:
            let vc = viewController as! AllViewController
            return vc.pageIndex
        }
    }
    @IBAction func menu(_ sender:CustomButton){
        self.navigationController?.revealViewController()?.revealSideMenu()
}
}
