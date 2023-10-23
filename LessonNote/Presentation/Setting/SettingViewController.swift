//
//  SettingViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/21.
//

import UIKit


final class SettingViewController: BaseViewController {
    
    private lazy var tableView = UITableView().then{
        $0.separatorColor = Color.gray2
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .clear
        $0.rowHeight = 55
    }
    let settingType = Setting.allCases
    
    override func setLayouts() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setNavigationBar(){
        navigationItem.title = "설정"
    }
    
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        cell.backgroundColor = Color.white
        cell.selectionStyle = .none
        
        let accessoryImageView = UIImageView().then{
            $0.image = Image.arrowRight
        }

        accessoryImageView.sizeToFit()
        cell.accessoryView = accessoryImageView
        var content = cell.defaultContentConfiguration()
        content.text =  settingType[indexPath.row].settingTitle
        content.textProperties.color = Color.black
        content.image = settingType[indexPath.row].settingImage
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1, let appURL = URL(string: "instagram://user?username=lessonnote.official"), UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            let vc = WebViewController()
            vc.settingType = Setting(rawValue: indexPath.row)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
