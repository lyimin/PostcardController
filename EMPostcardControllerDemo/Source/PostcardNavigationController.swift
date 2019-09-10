//
//  PostcardNavigationController.swift
//  EMPostcardControllerDemo
//
//  Created by EamonLiang on 2019/9/4.
//  Copyright © 2019 EamonLiang. All rights reserved.
//

import UIKit


/// 顶部导航栏的箭头样式
///
/// - none: 无
/// - black: 黑色往下箭头
/// - white: 白色往下箭头
public enum PostcardInteractiveBarStyle {
    case none
    case black
    case white
}

protocol PostcardNavigationControlling {
    
    /// 点击顶部topBar
    ///
    /// - Parameter nav: 导航栏
    func didTappedOnTopBarAtPostcard(nav: PostcardNavigationController)

    /// 顶部箭头
    ///
    /// - Parameter nav: 导航栏
    /// - Returns: 返回顶部箭头按钮样式
    func preferredInteractiveBarStyleAtPostcard(nav: PostcardNavigationController) -> PostcardInteractiveBarStyle;

    
    /// 注：如果该控制器有scrollView或者其子类。需要传入scrollView或其子类做手势交互
    ///
    /// - Parameter nav: 导航栏
    /// - Returns: 内容页面的scrollView或其子类
    func scrollViewShouldDetectAtPostcard(nav: PostcardNavigationController) -> UIScrollView?
}

open class PostcardNavigationController: UINavigationController {
    
    //MARK: >> Setter
    //------------------------------------------------------------------------
    
    /// 卡片post出来距离顶部的距离
    /// 默认是24 + 安全区域高度
    open var postcardMarginTop: CGFloat = 24 + DeviceUtil.safeAreaTopHeight
    
    /// 卡片顶部的圆角大小
    open var postcardCornerRadius: CGFloat = 13
    
    
    //MARK: >> Private Properties
    //------------------------------------------------------------------------
    
    private var transition: PostcardTransition!
    
    //MARK: >> Life Cycle
    //------------------------------------------------------------------------
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // hidden bar
        setNavigationBarHidden(true, animated: false)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        // transition
        transition = PostcardTransition()
        modalPresentationStyle = .custom
        transitioningDelegate = self
        delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("[%@ delloc]", NSStringFromClass(PostcardNavigationController.self))
    }
    
    open override var prefersStatusBarHidden: Bool {
        return false
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: >> override
    //------------------------------------------------------------------------
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let container = PostcardContainerViewController(withController: viewController)
        super.pushViewController(container, animated: animated)
    }
    
    open override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        let containers = viewControllers.map { (viewController) -> PostcardContainerViewController in
            let container = PostcardContainerViewController(withController: viewController)
            return container
        }
        super.setViewControllers(containers, animated: animated)
    }
}


//MARK: >> UINavigationControllerDelegate, UIViewControllerTransitioningDelegate
//------------------------------------------------------------------------

extension PostcardNavigationController: UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.mode = .present;
        return transition;
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.mode = .dismiss
        return transition
    }
    
    // TODO:
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    // TODO:
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // push
        if operation == .push {
            transition.mode = .push
            return transition
        }
            
        // pop
        else if operation == .pop {
            transition.mode = .pop
            return transition
        }
        return nil
    }
    
    // TODO:
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return nil
    }
}