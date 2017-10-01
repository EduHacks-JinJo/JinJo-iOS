//
//  CoursesViewController.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {
    static let identifier = "CoursesViewController"
    
    var courses = [String]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCourses()
    }
    
    private func setup() {
        setupTableView()
        navigationController?.navigationBar.tintColor = UIColor(red: 107/255, green: 186/255, blue: 183/255, alpha: 1.0)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CoursesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CoursesTableViewCell.identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 125
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    private func getCourses() {
        RoomService.shared.getCourses() { (success, courses) in
            if success {
                self.courses = courses
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func createAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Courses", bundle: nil).instantiateViewController(withIdentifier: CreateRoomViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Splash", bundle: nil).instantiateInitialViewController()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let window = appDelegate.window {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = vc
            }, completion: nil)
        }
    }
}

extension CoursesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Courses", bundle: nil).instantiateViewController(withIdentifier: CourseRoomsViewController.identifier) as! CourseRoomsViewController
        vc.config(courseID: courses[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CoursesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection  section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoursesTableViewCell.identifier, for: indexPath) as! CoursesTableViewCell
        cell.config(course: courses[indexPath.row])
        return cell
    }
}
