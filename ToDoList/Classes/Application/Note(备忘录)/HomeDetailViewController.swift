//
//  HomeDetailViewController.swift
//  RCT
//
//  Created by mac on 1.11.20.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit
class HomeDetailViewController: UIViewController {
    var item: NoteListModel?
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var detailLabel = UILabel()
    private var categoryLabel = UILabel()
    private var createTimeLabel = UILabel()
    private var remindTimeLabel = UILabel()
    
    private var titleTF = UITextField()
    private var subtitleTF = UITextField()
    private var detailTextarea = UITextField()
    private var categoryText = UITextField()
    private var createTime = UILabel()
    private var remindTime = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupData()
    }
    
    func setupData() {
        guard let data = item else {return}
        
        titleTF.text = data.title
        subtitleTF.text = data.subtitle
        detailTextarea.text = data.detail
    }
    func setupUI() {
        
        guard let backgroundImage = UIImage(named: "homeBG") else {return}
        view.backgroundColor = UIColor.init(patternImage: backgroundImage)

        title = "Preview"
        view.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.text = "文章标题"
        titleLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(60.0)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(300.0)
        }
        view.addSubview(titleTF)
        titleTF.backgroundColor = .white
        titleTF.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.titleLabel.mas_bottom)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(300.0)
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.textColor = .white
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 11)
        subtitleLabel.text = "文章副标题"
        subtitleLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.titleTF.mas_bottom)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(300.0)
        }
        view.addSubview(subtitleTF)
        subtitleTF.backgroundColor = .white
        subtitleTF.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.subtitleLabel.mas_bottom)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(300.0)
        }
        
        view.addSubview(detailLabel)
        detailLabel.textColor = .white
        detailLabel.font = UIFont.boldSystemFont(ofSize: 11)
        detailLabel.text = "请输入描述"
        detailLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.subtitleTF.mas_bottom)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(300.0)
        }
        view.addSubview(detailTextarea)
        detailLabel.layer.cornerRadius = 5.0
        detailLabel.clipsToBounds = true
        detailLabel.layer.masksToBounds = true
        detailTextarea.backgroundColor = .white
        detailTextarea.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.detailLabel.mas_bottom)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(60.0)
            make?.width.equalTo()(300.0)
        }
    }

/*
    let tableView = ASTableView()
    
    deinit {
        tableView.asyncDelegate = nil // 记得在这里将 delegate 设为 nil，否则有可能崩溃
        tableView.asyncDataSource = nil // dataSource 也是一样
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.bounds
        tableView.isHidden = true
        tableView.asyncDataSource = self
        tableView.asyncDelegate = self
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
        DispatchQueue.main.asyncAfter(deadline: .now()+0.30) {
            self.tableView.isHidden = false
        }
    }

    
    func configureTableView()
    {
        //_tableNode.view.tableFooterView = [[UIView alloc] init];
        //_tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
 */
}
//
//// MARK: - Public
//extension HomeDetailViewController: ASTableViewDelegate, ASTableViewDataSource {
//    func tableView(_ tableView: ASTableView!, nodeForRowAt indexPath: IndexPath!) -> ASCellNode! {
//        let cell = MyStatusCell()
//        cell?.text = "hello World!"
//        return cell
//    }
//
//    // MARK: - ASTableView Delegate
//    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
//
//        return 7
//    }
//
////    func tableView(tableView: ASTableView!, nodeForRowAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {}
//
//}
//
//// MARK: - Setup
//private extension HomeDetailViewController {
//
//    func setupUI() {
//
//        //navigationView.setup(title: "")
//        //navigationView.showBack()
//    }
//
//    func updateUI() {
//
//    }
//
//}
//
//// MARK: - Action
//private extension HomeDetailViewController {
//
//}
//
//// MARK: - Utiltiy
//private extension HomeDetailViewController {
//
//}

