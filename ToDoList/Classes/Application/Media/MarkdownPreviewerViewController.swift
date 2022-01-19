//
//  MarkdownPreviewerViewController.swift
//  ToDoList
//
//  Created by MarkLwis on 2022/1/5.
//  Copyright © 2022 mark. All rights reserved.
//

import UIKit
import WebKit
@available(iOS 8.0, *)
class MarkdownPreviewerViewController: UIViewController {
    private var webView = UIWebView()
    var filename: String?
    var fileContent: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        // 拷贝js文件到cache文件夹
        guard let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {return}
        let fileManager =  FileManager()
        guard let jsFoldURL = URL(string:"\(cachePath)/js") else {return}
        do {
            try fileManager.createDirectory(at: jsFoldURL, withIntermediateDirectories: false, attributes: nil)
            guard let jsfilePath = Bundle.main.path(forResource: "bs-markdown-ace", ofType: "js") else {return}
            try fileManager.copyItem(atPath: jsfilePath, toPath: "\(cachePath)/js/bs-markdown-ace.js")
        } catch {
            print("创建失败")
        }
        guard let text = fileContent else {
            // 打开文件失败
            return
        }
        loadContent(text)
    }
    // MARK: - WebView Set
    func setupUI () {
        
        title = filename
//        let wkUController = WKUserContentController()
//        let wkWebConfig = WKWebViewConfiguration()
//        wkWebConfig.userContentController = wkUController
//        webView = WKWebView(frame: .zero, configuration: wkWebConfig)
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
//        webView.scrollView.bouncesZoom = false
//        webView.scrollView.isScrollEnabled = false
        
        guard let statusHeight =  navigationController?.navigationBar.frame.size.height else {return}
        view.addSubview(webView)
        webView.mas_makeConstraints { make in
            make?.top.equalTo()(UIApplication.shared.statusBarFrame.size.height + statusHeight)
            make?.left.right().bottom().equalTo()(self.view)?.offset()(2.0)
            make?.width.equalTo()(self.view)
        }
        // webView.scrollView.contentOffset = CGPoint(x: view.bounds.size.width, y: 0)
    }
    
    func loadContent(_ content: String) {
        // let header = "<head>" + "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\"> " + "<style>img{width: 100%; height:auto;}*{margin:0;padding:0;boder:0}</style>" + "</head>"
        guard let htmlContentURL = Bundle.main.url(forResource: "index", withExtension: "html") else {return}
        let text = try? String(contentsOf: htmlContentURL)
        if let header = text {
            guard let part1Content = header.components(separatedBy: "#insert#").first else {return}
            guard let part2Content = header.components(separatedBy: "#insert#").last else {return}
            let html = part1Content + "\(content)" + part2Content
            // load html
            self.webView.loadHTMLString(html, baseURL: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - WKUIDelegate
@available(iOS 8.0, *)
extension MarkdownPreviewerViewController: WKUIDelegate {
  
}

// MARK: - WKNavigationDelegate
@available(iOS 8.0, *)
extension MarkdownPreviewerViewController: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    
    // self.hud.showLoading()
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    
    // self.hud.hideLoading()
    
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    
    // self.hud.showMessage(message: "服务器出小差，请稍后重试")
  }
}
