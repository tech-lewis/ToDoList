//
//  SquareTableViewController.swift
//  Demo1
//
//  Created by mac on 12.7.20.
//  Copyright © 2020 Tsinghua University. All rights reserved.
//

import UIKit
/// 添加监控代码
class SquareTableViewController: UITableViewController {

    var listDatas:[[String]] = [[String]]()
    let supportFormats = ["markdown", "mov"]
    let mediaTypes = ["mp4", "mov", "m4v"]

    func setupData(){
        for name in supportFormats {
            if (name == "markdown") {
                let array = getFileListWithFileExtensionType(type: name)
                let totalFilenames = array + getFileListWithFileExtensionType(type: "md")
                listDatas.append(totalFilenames)
            } else {
                listDatas.append(getFileListWithFileExtensionType(type: name))
            }
        }
    }
    
    @objc func startRunMonitor () {
        self.navigationItem.rightBarButtonItem = nil
    }
    /// MARK -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        self.navigationItem .rightBarButtonItem = UIBarButtonItem(title: "Start Monitor", style: .done, target: self, action: #selector(startRunMonitor))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return listDatas.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listDatas[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "exploreCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier:  identifier)
            cell?.selectionStyle = .blue //iOS 7 之后失效了的属性
        }
        // Configure the cell...
        //setup
        let groupData = listDatas[indexPath.section]
        cell?.textLabel?.text = groupData[indexPath.row]

        return cell!
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let groupTitle = supportFormats[section]
        return "本地文件(\(groupTitle)格式)"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let markdownExtensions = ["md", "markdown"]
        let groupTitle = supportFormats[indexPath.section]
        if (mediaTypes.contains(groupTitle)) {
            let fileBrowserVC = TLFilesBrowserViewController()
            fileBrowserVC.filesData = getFileListWithFileExtensionType(type: groupTitle)
            fileBrowserVC.hidesBottomBarWhenPushed = true
            //let nav = UINavigationController(rootViewController:fileBrowserVC)
            self.navigationController?.pushViewController(fileBrowserVC, animated: true)
            return;
        } else if (markdownExtensions.contains(groupTitle)) {
            /// 打开预览页面
            // iOS 8一下的设备不支持
            if (Double(UIDevice.current.systemVersion) ?? 7.0 >= 8.0) {
                // 弃用UIWebView
                if #available(iOS 8.0, *) {
                    let controller = MarkdownPreviewerViewController()
                    let groupData = listDatas[indexPath.section]
                    controller.filename = groupData[indexPath.row]
                    guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
                        // 路径错误
                        return
                    }
                    controller.fileContent = try? String.init(contentsOfFile: "\(path)/\(controller.filename ?? "None")")
                    controller.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(controller, animated: true)
                } else {
                    // Fallback on earlier versions
                }
            } else {
                if #available(iOS 8.0, *) {
                    let controller = MarkdownPreviewerViewController()
                    
                    controller.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(controller, animated: true)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Files Explore
    func getFileListWithFileExtensionType(type: String?) -> [String]
    {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

        let fileMgr = FileManager.default
        //var fileList = [String]()
        do{
            let arr = try fileMgr.contentsOfDirectory(atPath: documentPaths)
            
            if let fileExt = type{
                let array = arr as NSArray
                 return (array.pathsMatchingExtensions([fileExt]))
            }
        }
        catch{
            return [String]()
        }
        
        return [String]()
    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
