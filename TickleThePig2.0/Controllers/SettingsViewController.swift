//
//  ViewController.swift
//  SettingsTemplate
//
//  Created by Stephen Dowless on 2/10/19.
//  Copyright © 2019 Stephan Dowless. All rights reserved.
//

import UIKit
import FirebaseAuth

private let reuseIdentifier = "SettingsCell"

class SettingsViewController: UIViewController {
        
    var tableView: UITableView!
    var userInfoHeader: UserInfoHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = UIView()
    }
    
    func configureUI() {
        configureTableView()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        navigationItem.title = "Settings"
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

//        guard let section = SettingsSection(rawValue: section) else {return 0}
        return SocialOptions.allCases.count
//        switch section {
//        case .Social: return SocialOptions.allCases.count
//        case .Communications: return CommunicationsOptions.allCases.count
//        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha:   1)

        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true

        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell

//        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
//        switch section {
//        case .Social:
            let social = SocialOptions(rawValue: indexPath.row)
            cell.textLabel?.text = social?.description
//        case .Communications:
//            let communications = CommunicationsOptions(rawValue: indexPath.row)
//            cell.textLabel?.text = communications?.description
//        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("signOut failed")
        }
        transitionToHome()
    }

    func transitionToHome() {
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.launchViewController)
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
}

