//
//  OptionsViewController.swift
//  NativeKit
//
//  Created by Zhilei Zheng on 5/3/19.
//  Copyright © 2019 Zhilei Zheng. All rights reserved.
//

import UIKit
import SnapKit

class OptionsViewController: UIViewController {
    
    // MARK: UIElements
    
    let tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero);
        return view;
    }()
    
    let refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.backgroundColor = UIColor.clear
        view.tintColor = UIColor.clear
        return view
    }()
    
    let customView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        return view;
    }()
    
    let topView : UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        if let flowLayout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 0)
        }
        collection.bounces = true
        collection.backgroundColor = .black
        return collection
    }()
    
    
    // MARK: DATA
    
    var dataArray = ["One", "Two", "Three", "Four", "Five"]
    
    
    // MARK: Set up Layout
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "idCell")
        tableView.addSubview(refreshControl)
        tableView.snp.makeConstraints { (view) in
            view.left.equalToSuperview()
            view.right.equalToSuperview()
            view.top.equalTo(self.view.safeAreaLayoutGuide)
            view.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func setUpTopView() {
        refreshControl.addSubview(customView)
        customView.snp.makeConstraints { (view) in
            view.left.right.equalTo(refreshControl)
            view.height.equalTo(80)
            view.centerY.equalTo(refreshControl)
        }
    }
    
    let innerShadow = CALayer()
    override func viewDidAppear(_ animated: Bool) {
        innerShadow.frame = customView.bounds
        // Shadow path (1pt ring around bounds)
        print(innerShadow.frame)
        let path = UIBezierPath(rect: innerShadow.bounds.insetBy(dx: -3, dy: -3))
        let cutout = UIBezierPath(rect: innerShadow.bounds).reversing()
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        // Shadow properties
        innerShadow.shadowColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1.0).cgColor
        innerShadow.shadowOffset = CGSize.zero
        innerShadow.shadowOpacity = 1
        innerShadow.shadowRadius = 3
        // Add
        customView.layer.addSublayer(innerShadow)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpTopView()
    }
    
    
    // MARK: Properties Used by Scroll View Delegate
    
    var canRefresh = true
    var lastContentOffset: CGFloat = 0.0
    var isDragging = false
    var isHidden = true;
    
}

extension OptionsViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath as IndexPath)
        cell.textLabel!.text = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

extension OptionsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        refreshControl.endRefreshing();
    }
}


extension OptionsViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < -30) {
            let alpha = 2 * (scrollView.contentOffset.y + 30) / -60;
            customView.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha: alpha)
            innerShadow.shadowColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: alpha).cgColor
        }
        if scrollView.contentOffset.y < -90 {
            if (isDragging) {
                scrollView.setContentOffset(CGPoint(x: 0, y: -90), animated: false)
            }
            if (canRefresh && !self.refreshControl.isRefreshing) {
                self.canRefresh = false
                self.refreshControl.beginRefreshing()
            }
        } else if scrollView.contentOffset.y > -70 {
            if lastContentOffset < scrollView.contentOffset.y && isDragging {
                self.canRefresh = true
                self.refreshControl.endRefreshing()
            }
        }
        lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDragging = true
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        isDragging = false
        if (scrollView.contentOffset.y < -5 && velocity.y < -0.5) {
            if canRefresh && !self.refreshControl.isRefreshing {
                self.canRefresh = false
                self.refreshControl.beginRefreshing()
            }
        }
    }
}
