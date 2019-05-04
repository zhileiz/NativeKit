//
//  ListViewController.swift
//  NativeKit
//
//  Created by Zhilei Zheng on 5/3/19.
//  Copyright © 2019 Zhilei Zheng. All rights reserved.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {

    let tableView : UITableView = {
        var table = UITableView(frame: .zero)
        table.bounces = true
        return table
    }()
    
    var topViewHeight = 0
    
    let topView : UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        if let flowLayout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
//            flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 0)
        }
        collection.bounces = true
        collection.backgroundColor = .black
        return collection
    }()
    
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
    
    let scripts = [
        "https://penncoursereview.com/",
        "https://pennlabs.org/",
        "https://penncoursealert.com/",
        "https://penncoursereview.com/",
        "https://pennlabs.org/",
        "https://penncoursealert.com/",
        "https://penncoursereview.com/",
        "https://pennlabs.org/",
        "https://penncoursealert.com/",
        "https://penncoursereview.com/",
        "https://pennlabs.org/",
        "https://penncoursealert.com/"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topView)
        view.addSubview(tableView)
        // tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "course")
        // collectionview
        topView.delegate = self
        topView.dataSource = self
        topView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "script")
        // layout
        topView.snp.makeConstraints { (view) in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            view.height.equalTo(topViewHeight)
            view.left.equalToSuperview()
            view.right.equalToSuperview()
        }
        tableView.snp.makeConstraints { (view) in
            view.left.equalToSuperview()
            view.right.equalToSuperview()
            view.top.equalTo(topView.snp.bottom)
            view.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Courses"
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:.subtitle, reuseIdentifier: "course")
        cell.detailTextLabel?.text = courses[indexPath.row].code
        cell.textLabel?.text = courses[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView == tableView) {
            if (scrollView.contentOffset.y < -30 && decelerate) { showTop() }
            else { hideTop() }
        }
    }
    
    func showTop() {
        if (topViewHeight == 0) {
            topViewHeight = 70
            topView.snp.updateConstraints { (view) in
                view.height.equalTo(topViewHeight)
            }
            UIView.animate(withDuration: 0.12, delay: 0, options: [.curveEaseOut], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func hideTop() {
        if (topViewHeight == 70) {
            topViewHeight = 0
            view.setNeedsLayout()
            topView.snp.updateConstraints { (view) in
                view.height.equalTo(topViewHeight)
            }
            UIView.animate(withDuration: 0.12, delay: 0, options: [.curveEaseOut], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scripts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "script", for: indexPath)
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.layer.masksToBounds = true
        if (cell.contentView.subviews.count < 1) {
            let imageView = UIImageView.init(frame: cell.frame)
            imageView.image = UIImage(named: "tinder")
            cell.contentView.addSubview(imageView)
            imageView.snp.makeConstraints { (view) in
                view.centerX.centerY.equalToSuperview()
                view.width.height.equalToSuperview()
            }
        }
        return cell
    }
}
