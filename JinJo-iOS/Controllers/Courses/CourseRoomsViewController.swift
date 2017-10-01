//
//  CourseRoomsViewController.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class CourseRoomsViewController: UIViewController {
    static let identifier = "CourseRoomsViewController"

    var rooms = [Room]()
    var courseID: String!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func config(courseID: String) {
        navigationItem.title = courseID
        self.courseID = courseID
    }
    
    private func setup() {
        setupTableView()
        navigationController?.navigationBar.tintColor = UIColor(red: 107/255, green: 186/255, blue: 183/255, alpha: 1.0)
        RoomService.shared.getRooms(courseID: courseID) { (success, rooms) in
            if success {
                self.rooms = rooms
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CourseRoomsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CourseRoomsTableViewCell.identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 125
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
}

extension CourseRoomsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Room", bundle: nil).instantiateViewController(withIdentifier: RoomViewController.identifier) as! RoomViewController
        if let roomID = rooms[indexPath.row].roomID {
            vc.config(roomID: roomID, roomControllerState: .instructor)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CourseRoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection  section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CourseRoomsTableViewCell.identifier, for: indexPath) as! CourseRoomsTableViewCell
        cell.config(room: rooms[indexPath.row])
        return cell
    }
}
