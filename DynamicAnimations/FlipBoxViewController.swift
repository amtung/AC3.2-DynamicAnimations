//
//  FlipBoxViewController.swift
//  DynamicAnimations
//
//  Created by Annie Tung on 1/26/17.
//  Copyright © 2017 AccessCode. All rights reserved.
//

import UIKit
import SnapKit

class FlipBoxViewController: UIViewController {
    
    let squareSize = CGSize(width: 100, height: 100)
    var dynamicAnimator: UIDynamicAnimator? = nil
    var animator: UIViewPropertyAnimator? = UIViewPropertyAnimator(duration: 2.0, curve: UIViewAnimationCurve.linear, animations: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupViewHierarchy()
        configureConstraint()
        self.dynamicAnimator = UIDynamicAnimator(referenceView: view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let bouncyBehavior = BouncyViewBehavior(items: [blueView])
//        self.dynamicAnimator?.addBehavior(bouncyBehavior)
    }
    
    // MARK: - Movements
    
    internal func pickup(view: UIView) {
        animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut, animations: {
            view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
        animator?.startAnimation()
    }
    
    internal func putDown(view: UIView) {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn, animations: { 
            view.transform = CGAffineTransform.identity
        })
        animator?.startAnimation()
    }
    
    internal func move(view: UIView, to point: CGPoint) {
        if animator!.isRunning {
            animator?.addAnimations {
                self.view.layoutIfNeeded()
            }
        }
        view.snp.remakeConstraints { (view) in
            view.center.equalTo(point)
            view.size.equalTo(squareSize)
        }
    }
    
    // MARK: - Tracking Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchWasInsideBlueView = blueView.frame.contains(touch.location(in: view))
        if touchWasInsideBlueView {
            pickup(view: blueView)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        putDown(view: blueView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        move(view: blueView, to: touch.location(in: view))
    }
    
    // MARK: - Set Up
    
    private func setupViewHierarchy() {
        self.view.addSubview(blueView)
        self.view.isUserInteractionEnabled = true
    }
    
    private func configureConstraint() {
        blueView.snp.makeConstraints { (view) in
            view.center.equalToSuperview()
            view.size.equalTo(squareSize)
        }
    }

    // MARK: - Views
    
    internal lazy var blueView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .blue
        return view
    }()
}
