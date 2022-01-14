//
//  HomeTableViewController.swift
//  SwiftMRK
//
//  Created by Mark on 2020/3/23.
//  Copyright © 2020年 markmarklewis. All rights reserved.
//
import UIKit

class HomeTableViewController: UITableViewController {
    // MARK: - 属性
    var listDatas:[NoteListModel] = NoteCacheTools.findAllNotes()
    
    @objc func addTestData() {
//        let data = NoteListModel(title: "Welcome!", subtitle: "hello world", detail: "this is a test data", category: NSNumber(integerLiteral: 1), remind: "")
//        listDatas.append(data)
//        // sql
//        NoteCacheTools.addStatus(data)
//        self.tableView.reloadData()
        let controller = AddNewNoteController()
        controller.completeBlock = { (item) in
            NoteCacheTools.addStatus(item)
            self.listDatas = NoteCacheTools.findAllNotes()
//            listDatas.append(item)
            self.tableView.reloadData()
        }
        
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true) {
            //
        }
    }
  
  
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 当前分辨率截屏
        // let v = self.tabBarController?.view
//        UIGraphicsBeginImageContextWithOptions(v?.bounds.size ?? .zero, false, UIScreen.main.scale)
//        v?.layer.render(in: UIGraphicsGetCurrentContext()!)
//        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
//        UIGraphicsEndImageContext()
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTestData))
//      NotificationCenter.default.addObserver(self, selector: #selector(addTestData), name: clickCenterButtonNotification, object: nil)
    }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
}


extension HomeTableViewController {
    // 数据源和代理方法
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listDatas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "homeDetailCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier:  identifier)
        }
        // Configure the cell...
        //setup
        cell?.textLabel?.text = listDatas[indexPath.row].title

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = HomeDetailViewController()
        controller.item = listDatas[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
