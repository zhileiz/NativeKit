//
//  OptionsViewController.swift
//  NativeKit
//
//  Created by Zhilei Zheng on 5/3/19.
//  Copyright © 2019 Zhilei Zheng. All rights reserved.
//

import UIKit
import SnapKit

class CoursesViewController: UIViewController {
    
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
    
    let topView : UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        if let flowLayout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 5, right: 0)
            flowLayout.itemSize = CGSize(width: 50, height: 50)
        }
        collection.bounces = true
        collection.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        return collection
    }()
    
    // MARK: DATA
    
    let courses = [
        Course(code: "CIS-99", title: "Undergraduate Research / Independent Study"),
        Course(code: "CIS-105", title: "Computational Data Exploration"),
        Course(code: "CIS-110", title: "Introduction to Computer Programming"),
        Course(code: "CIS-120", title: "Programming Languages and Techniques I "),
        Course(code: "CIS-121", title: "Programming Languages and Techniques II "),
        Course(code: "CIS 160", title: "Mathematical Foundations of Computer Science"),
        Course(code: "CIS-240", title: "Introduction to Computer Architecture"),
        Course(code: "CIS-262", title: "Automata, Computability, and Complexity "),
        Course(code: "CIS-320", title: "Introduction to Algorithms"),
        Course(code: "CIS-331", title: "Intro to Networks and Security"),
        Course(code: "CIS-341", title: "Compilers and Interpreters"),
        Course(code: "CIS-350", title: "Software Design/Engineering "),
        Course(code: "CIS 371", title: "Computer Organization and Design "),
        Course(code: "CIS-380", title: "Computer Operating Systems ")
    ]
    
    let scripts:[Script] = [
        Script(title: "ZZact Demo", url: "http://localhost:8081/", content: "", image: "pcr"),
        Script(title: "Penn Course Alert", url: "https://penncoursealert.com/", content: "", image: "pca"),
        Script(title: "Bilibili Videos", url: "https://www.bilibili.com/", content: "", image: "bilibili")
    ]
    
    
    // MARK: Set up Layout
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "idCell")
        tableView.addSubview(refreshControl)
        tableView.sendSubviewToBack(refreshControl)
        tableView.snp.makeConstraints { (view) in
            view.left.equalToSuperview()
            view.right.equalToSuperview()
            view.top.equalTo(self.view.safeAreaLayoutGuide)
            view.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func setUpTopView() {
        refreshControl.addSubview(topView)
        topView.snp.makeConstraints { (view) in
            view.left.right.equalTo(refreshControl)
            view.height.equalTo(80)
            view.centerY.equalTo(refreshControl)
        }
        // collectionview
        topView.delegate = self
        topView.dataSource = self
        topView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "script")
    }
    
    let innerShadow = CALayer()
    
    override func viewDidAppear(_ animated: Bool) {
        innerShadow.frame = topView.bounds
        // Shadow path (1pt ring around bounds)
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
        topView.layer.addSublayer(innerShadow)
        self.title = "Course"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpTopView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.topItem?.title = "Courses"
    }
    
    
    
    // MARK: Properties Used by Scroll View Delegate
    
    var canRefresh = true
    var lastContentOffset: CGFloat = 0.0
    var isDragging = false
    var isHidden = true;
    
}

extension CoursesViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:.subtitle, reuseIdentifier: "idCell")
        cell.detailTextLabel?.text = courses[indexPath.row].code
        cell.textLabel?.text = courses[indexPath.row].title
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

extension CoursesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CoursesViewController : UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scripts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "script", for: indexPath)
        let script = scripts[indexPath.row]
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.layer.masksToBounds = true
        if (cell.contentView.subviews.count < 1) {
            let imageView = UIImageView.init(frame: cell.frame)
            imageView.image = script.image
            cell.contentView.addSubview(imageView)
            imageView.snp.makeConstraints { (view) in
                view.centerX.centerY.equalToSuperview()
                view.width.height.equalToSuperview()
            }
        }
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let script = scripts[indexPath.row]
        let viewController = WebViewController()
        viewController.script = script
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension CoursesViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < -30) {
            let alpha = 2 * (scrollView.contentOffset.y + 30) / -60;
//            topView.backgroundColor = UIColor(red: 0.92, green:0.92, blue:0.92, alpha: alpha)
            topView.alpha = alpha
//            innerShadow.shadowColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: alpha).cgColor
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
