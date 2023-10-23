//
//  WebViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/21.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController {
    
    var webView = WKWebView()
    var settingType: Setting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let settingType else {return}
        openWebPage(to: settingType.path)
    }
    
    override func setLayouts() {
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setNavigationBar() {
        navigationItem.title = settingType?.settingTitle
    }
    
    func openWebPage(to urlStr: String) {
        guard let url = URL(string: urlStr) else {
            print("invalid url")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
