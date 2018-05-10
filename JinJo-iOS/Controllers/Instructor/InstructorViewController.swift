//
//  InstructorViewController.swift
//  JinJo-iOS
//
//  Created by Paco Lee on 2017-09-30.
//  Copyright © 2017 Paco Lee. All rights reserved.
//

import UIKit

class InstructorViewController: UIViewController {
    static let identifier = "InstructorViewController"
    
    var rooms = [Room]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRooms()
    }
    
    private func setup() {
        setupTableView()
        navigationController?.navigationBar.tintColor = UIColor(red: 107/255, green: 186/255, blue: 183/255, alpha: 1.0)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: InstructorTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: InstructorTableViewCell.identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 125
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    private func getRooms() {
        let id = UserDefaults.standard.integer(forKey: "id")
        RoomService.sharedService.getRooms(instructorID: id) { (result) in
            if let rooms = result.value {
                self.rooms = rooms
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func createAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Instructor", bundle: nil).instantiateViewController(withIdentifier: CreateRoomViewController.identifier)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Splash", bundle: nil).instantiateInitialViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if let window = appDelegate.window {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                UserDefaults.standard.set(-1, forKey: "id")
                window.rootViewController = vc
            }, completion: nil)
        }
    }
}

extension InstructorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Instructor", bundle: nil).instantiateViewController(withIdentifier: InstructorRoomViewController.identifier) as! InstructorRoomViewController
        vc.config(room: rooms[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension InstructorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection  section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InstructorTableViewCell.identifier, for: indexPath) as! InstructorTableViewCell
        cell.config(room: rooms[indexPath.row])
        return cell
    }
}
