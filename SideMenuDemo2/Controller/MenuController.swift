//
//  ViewController.swift
//  SideMenuDemo2
//
//  Created by Sebastian Strus on 2019-06-02.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

    var menuView: MenuView!
    
    var menuShowing = false
    var sideMenuXAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
    }
    
    lazy var containerSideMenu: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    lazy var waveContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var toWaveView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var waveImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "wave_icon")?.withRenderingMode(.alwaysTemplate))
        iv.tintColor = UIColor.white
        iv.contentMode = UIView.ContentMode.scaleToFill
        return iv
    }()
    
    
    
    
   
    
    func setupNavBar() {
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu_icon2")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = menuBtn
    }
    
    func setupView() {
        menuView = MenuView()
        view.addSubview(menuView)
        menuView.pinToEdges(view: view)
        
        // add static container for side menu, initially hidden
        view.addSubview(containerSideMenu)
        containerSideMenu.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0).isActive = true
        containerSideMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        containerSideMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -160).isActive = true
        containerSideMenu.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        
        
        //add wave view shape
        containerSideMenu.addSubview(waveContainerView)
        waveContainerView.topAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: 0).isActive = true
        waveContainerView.bottomAnchor.constraint(equalTo: containerSideMenu.bottomAnchor, constant: 0).isActive = true
        waveContainerView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        sideMenuXAnchor = waveContainerView.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: -80)
        sideMenuXAnchor?.isActive = true
        //waveContainerView.centerXAnchor.constraint(equalTo: containerSideMenu.leadingAnchor, constant: 160).isActive = true
        
        
        waveContainerView.addSubview(toWaveView)
        toWaveView.setAnchor(top: waveContainerView.topAnchor, leading: waveContainerView.leadingAnchor, bottom: waveContainerView.bottomAnchor, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 0)
        
        
        waveContainerView.addSubview(waveImageView)
        waveImageView.setAnchor(top: waveContainerView.topAnchor, leading: nil, bottom: waveContainerView.bottomAnchor, trailing: waveContainerView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 0)
        
        
        
        
 
        
        
        
        
        
        
        
        
    }

    @objc func toggleMenu() {
        if menuShowing {
            UIView.animate(withDuration: 0.7) {
                self.sideMenuXAnchor?.isActive = false
                self.sideMenuXAnchor = self.waveContainerView.centerXAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -80)
                self.sideMenuXAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.7) {
                self.sideMenuXAnchor?.isActive = false
                self.sideMenuXAnchor = self.waveContainerView.centerXAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80)
                self.sideMenuXAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }
        }
        menuShowing = !menuShowing
    }
}




















extension UIView {
    
    func createStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }
    
    func setAnchor(width: CGFloat, height: CGFloat) {
        
        self.setAnchor(top: nil,
                       leading: nil,
                       bottom: nil,
                       trailing: nil,
                       paddingTop: 0,
                       paddingLeft: 0,
                       paddingBottom: 0,
                       paddingRight: 0,
                       width: width,
                       height: height)
    }
    
    func setAnchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leadingAnchor
        }
        return leadingAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.trailingAnchor
        }
        return trailingAnchor
    }
    
    func setCellShadow() {
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.cornerRadius = 4
    }
    
    func pinToEdges(view: UIView) {
        setAnchor(top: view.topAnchor,
                  leading: view.leadingAnchor,
                  bottom: view.bottomAnchor,
                  trailing: view.trailingAnchor,
                  paddingTop: 0,
                  paddingLeft: 0,
                  paddingBottom: 0,
                  paddingRight: 0)
    }
    
    func pinToSafeEdges(view: UIView) {
        setAnchor(top: view.safeTopAnchor,
                  leading: view.safeLeadingAnchor,
                  bottom: view.safeBottomAnchor,
                  trailing: view.safeTrailingAnchor,
                  paddingTop: 0,
                  paddingLeft: 0,
                  paddingBottom: 0,
                  paddingRight: 0)
    }
}

