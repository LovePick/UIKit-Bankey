//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by Supapon Pucknavin on 2/11/2565 BE.
//

import Foundation
import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    
    // MARK: - VIEW
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    let closeButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let previousButton = UIButton(type: .system)
    
    // MARK: - PROPERTY
    weak var delegate: OnboardingContainerViewControllerDelegate?
    var currentPageIndex: Int = 0
    
    
    // MARK: - INIT
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989.")
        let page2 = OnboardingViewController(heroImageName: "world", titleText: "Move your money around the world quickly and securely.")
        let page3 = OnboardingViewController(heroImageName: "thumbs", titleText: "Learn more at www.bankey.com.")
        
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
        
        
    }
}

// MARK: - FUNCTION
extension OnboardingContainerViewController {
    private func setup(){
        view.backgroundColor = .systemPurple
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    
    private func style(){
        
        //Page Control
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        
        
        // Close
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        view.addSubview(closeButton)
        
        // Next
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        view.addSubview(nextButton)
        
        
        // Previous
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.setTitle("Previous", for: [])
        previousButton.addTarget(self, action: #selector(previousTapped), for: .primaryActionTriggered)
        view.addSubview(previousButton)
        previousButton.isHidden = true
        
    }
    
    private func layout(){
        // Close
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
        
        
        // Next
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 4)
        ])
        
        // Previous
        NSLayoutConstraint.activate([
            previousButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: previousButton.bottomAnchor, multiplier: 4.0)
        ])
    }
    
    
    func updateButton(currentIndex: Int) {
        print(currentIndex)
        
        if(currentIndex == 0){
            previousButton.isHidden = true
            nextButton.setTitle("Next", for: [])
        }else if(currentIndex >= pages.count - 1) {
            previousButton.isHidden = false
            nextButton.setTitle("Done", for: [])
        }else{
            previousButton.isHidden = false
            nextButton.setTitle("Next", for: [])
        }
    }
    
}



// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        //        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        //        currentVC = pages[index - 1]
        //        return pages[index - 1]
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil}
        if currentIndex == 0 {
            return nil
        } else {
            currentVC = pages[currentIndex - 1]
            return pages[currentIndex - 1]
        }
        
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        
        //        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        //        currentVC = pages[index + 1]
        //        return pages[index + 1]
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil}
        
        if currentIndex < pages.count - 1 {
            currentVC = pages[currentIndex + 1]
            return pages[currentIndex + 1]
        } else {
            
            return nil
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

// MARK: - OnboardingContainerViewController
extension OnboardingContainerViewController: UIPageViewControllerDelegate {
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        print(currentIndex)
        currentPageIndex = currentIndex
        updateButton(currentIndex: currentIndex)
        
        
    }
    
    
    
    
}


// MARK: - ACTION
extension OnboardingContainerViewController {
    
    @objc func closeTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
    
    @objc func doneTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
    
    
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = pageViewController.viewControllers?[0] else { return }
        guard let nextPage = pageViewController.dataSource?.pageViewController(pageViewController, viewControllerAfter: currentPage) else {
            currentPageIndex = pages.count - 1
            return
        }
        
        pageViewController.setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = pageViewController.viewControllers?[0] else { return }
        guard let prevPage = pageViewController.dataSource?.pageViewController(pageViewController, viewControllerBefore: currentPage) else {
            currentPageIndex = 0
            
            return
        }
        
        pageViewController.setViewControllers([prevPage], direction: .reverse, animated: animated, completion: completion)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        pageViewController.setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
    
    
    @objc func nextTapped(_ sender: UIButton) {
        print("nextTapped")
        currentPageIndex += 1
        if(currentPageIndex >= pages.count){
            currentPageIndex = pages.count - 1
            delegate?.didFinishOnboarding()
        }else{
            goToNextPage()
            updateButton(currentIndex: currentPageIndex)
        }
        
    }
    
    @objc func previousTapped(_ sender: UIButton) {
        print("previousTapped")
        currentPageIndex -= 1
        if(currentPageIndex < 0){
            currentPageIndex = 0
        }
        goToPreviousPage()
        updateButton(currentIndex: currentPageIndex)
        
    }
    
    
    
}
