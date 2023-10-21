//
//  WebViewController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/21.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {
    
    var webView = WKWebView()
    var settingType: SettingType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let settingType else {return}
        if let url = URL(string: settingType.path){
            let myRequest = URLRequest(url: url)
            webView.load(myRequest)
        }
    }
    
    override func setLayouts() {
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    override func setNavigationBar(){
        navigationItem.title = settingType?.settingTitle
    }
    
}

extension WebViewController: WKUIDelegate {
    func reloadButtonClicked() {
        webView.reload()
    }
    
    func goBackButtonClicked(){
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForwardButtonClicked(){
        if webView.canGoForward{
            webView.goForward()
        }
    }
}
