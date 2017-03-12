//
//  TutorialPageViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/12/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

class TutorialPageviewController: UIPageViewController {
    override func viewDidLoad() {
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.subviews.forEach {
            if let pageControl = $0 as? UIPageControl {
                pageControl.pageIndicatorTintColor = .lightGray
                pageControl.currentPageIndicatorTintColor = .black
            }
        }
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [
            self.newTutorial(text: "Nhấn vào bất kỳ nhóm cơ nào để xem các bài tập của nhóm cơ đó", imageName: "Tap"),
            self.newTutorial(text: "Dùng 2 ngón hoặc nhấn 2 lần để zoom", imageName: "Zoom"),
            self.newTutorial(text: "Nhấn và giữ để hiện tên nhóm cơ", imageName: "Long Press")
        ]
    }()
    
    func newTutorial(text: String, imageName: String) -> UIViewController {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "Tutorial0") as! FirstTutorialViewController
        vc.text = text
        vc.imageName = imageName
        return vc
    }
}

extension TutorialPageviewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
