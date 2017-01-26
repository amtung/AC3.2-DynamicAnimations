//
//  ViewController.swift
//  DynamicAnimations
//
//  Created by Louis Tur on 1/26/17.
//  Copyright © 2017 AccessCode. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var dynamicAnimator: UIDynamicAnimator? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupHierarchy()
        configureConstraints()
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view) // frame of reference
    }
    
    override func viewDidAppear(_ animated: Bool) { // layout drawing phrase should happen here
        super.viewDidAppear(animated)
        
        let gravityBehavior = UIGravityBehavior(items: [blueView])
//        gravityBehavior.angle = CGFloat.pi / 6.0
        gravityBehavior.magnitude = 0.2 // default: 1.0
        self.dynamicAnimator?.addBehavior(gravityBehavior)
    }
    
    // MARK: - Methods

    private func configureConstraints() {
        self.edgesForExtendedLayout = []
        
        blueView.snp.makeConstraints { (view) in
            view.top.centerX.equalToSuperview()
            view.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        snapButton.snp.makeConstraints { (button) in
            button.centerX.equalToSuperview()
            button.bottom.equalToSuperview().inset(50.0)
        }
    }
    
    private func setupHierarchy() {
        self.view.addSubview(blueView)
        self.view.addSubview(snapButton)
        
        self.snapButton.addTarget(self, action: #selector(snapToCenter), for: .touchUpInside)
    }
    
    internal func snapToCenter(_ view: UIView) {
        let snappingBehavior = UISnapBehavior(item: blueView, snapTo: self.view.center)
        snappingBehavior.damping = 1.0
        self.dynamicAnimator?.addBehavior(snappingBehavior)
    }
    
    // MARK: - Lazy Var
    
    internal lazy var blueView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    internal lazy var snapButton: UIButton = {
        let button: UIButton = UIButton(type: .roundedRect)
        button.setTitle("SNAP!", for: .normal)
        return button
    }()
    
}

