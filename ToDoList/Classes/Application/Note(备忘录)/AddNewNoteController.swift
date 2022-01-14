//
//  AddNewNoteController.swift
//  ToDoList
//
//  Created by MarkLewis on 2021/12/26.
//  Copyright © 2021 mark. All rights reserved.
//

import UIKit

class AddNewNoteController: UIViewController {

    private var categoryValue = 6 //默认为其他
    private var remindTime: String?
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var detailLabel = UILabel()
    private var categoryBtn = UIButton(type: .custom)
    private var remindTimeBtn = UIButton(type: .custom)
    //
    private var titleTF = UITextField()
    private var subtitleTF = UITextField()
    private var detailTextarea = NoteEditTextField()
    private var categoryText = UILabel()
    private var createTime = UILabel()
    private var remindTimeLabel = UILabel()
    private var item: NoteListModel?
    public var completeBlock: ((NoteListModel)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(addNewItem))
    }
  @objc func cancel() {
    dismiss(animated: true, completion: nil)
  }

    @objc func addNewItem() {
        guard let block = completeBlock else {return}
        
        guard let text = titleTF.text else {return}
        guard let subtext = subtitleTF.text else {return}
        guard let detailtext = detailTextarea.text else {return}
        guard let time = remindTime else {
            if #available(iOS 8.0, *) {
                let alertView = UIAlertController(title: "未选择完成时间", message: "点击灰色按钮选择时间", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertView, animated: true, completion: nil)
            } else {
                // Fallback on earlier versions
            }
            return
        }
        if (time.count <= 0) {
            if #available(iOS 8.0, *) {
                let alertView = UIAlertController(title: "未选择完成时间", message: "点击灰色按钮选择时间", preferredStyle: .alert)
                self.present(alertView, animated: true, completion: nil)
            } else {
                // Fallback on earlier versions
            }
            return
        }
        item = NoteListModel(title: text, subtitle: subtext, detail: detailtext, category: NSNumber(integerLiteral: categoryValue), remind: time)
        item?.idstr = NSNumber(integerLiteral: NoteCacheTools.findAllNotes().count + 1)
        guard let newNote = item else {return}
        block(newNote)
        dismiss(animated: true) {
            print("保存成功")
        }
    }
    func setupUI() {
        guard let statusHeight =  navigationController?.navigationBar.frame.size.height else {return}
        view.backgroundColor = .gray
        title = "新增"
        guard let backgroundImage = UIImage(named: "homeBG") else {return}
        view.backgroundColor = UIColor.init(patternImage: backgroundImage)
        view.addSubview(titleLabel)
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.text = "文章标题"
        titleLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(UIApplication.shared.statusBarFrame.size.height + statusHeight)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(300.0)
        }
        view.addSubview(titleTF)
        titleTF.backgroundColor = .clear
        titleTF.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.titleLabel.mas_bottom)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(300.0)
        }
        let titleBottomBorder = UIView()
        titleBottomBorder.backgroundColor = UIColor.darkText
        titleTF.addSubview(titleBottomBorder)
        titleBottomBorder.mas_makeConstraints { make in
            make?.top.equalTo()(self.titleTF.mas_bottom)
            make?.width.equalTo()(self.titleTF.mas_width)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(1)
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 11)
        subtitleLabel.text = "文章副标题"
        subtitleLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.titleTF.mas_bottom)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(300.0)
        }
        view.addSubview(subtitleTF)
        subtitleTF.backgroundColor = .clear
        subtitleTF.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.subtitleLabel.mas_bottom)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(300.0)
        }
        let titleBottomBorder2 = UIView()
        titleBottomBorder2.backgroundColor = UIColor.gray
        subtitleTF.addSubview(titleBottomBorder2)
        titleBottomBorder2.mas_makeConstraints { make in
            make?.top.equalTo()(self.subtitleTF.mas_bottom)
            make?.width.equalTo()(self.subtitleTF.mas_width)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(1)
        }
        
        view.addSubview(detailLabel)
        detailLabel.textColor = .gray
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
        detailTextarea.backgroundColor = .clear
        detailTextarea.selectFirstMenuIemBlock = {
            let controller = AddNewNoteEditorController()
            controller.finishEditingBlock = { (text) in
                self.detailTextarea.text = text
            }
            self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        }
        detailTextarea.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.detailLabel.mas_bottom)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(300.0)
        }
        let detailBottomBorder = UIView()
        detailBottomBorder.backgroundColor = UIColor.gray
        detailTextarea.addSubview(detailBottomBorder)
        detailBottomBorder.mas_makeConstraints { make in
            make?.top.equalTo()(self.detailTextarea.mas_bottom)
            make?.width.equalTo()(self.detailTextarea.mas_width)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(1)
        }
        
        
        view.addSubview(createTime)
        createTime.textColor = .gray
        createTime.font = UIFont.boldSystemFont(ofSize: 11)
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd hh:mm"
        createTime.text = "创建时间为" + fmt.string(from: Date())
        createTime.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.detailTextarea.mas_bottom)
            make?.centerX.equalTo()(self.view)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(300.0)
        }
        
        view.addSubview(categoryText)
        categoryText.textColor = .gray
        categoryText.font = UIFont.boldSystemFont(ofSize: 11)
        categoryText.text = "未选择分类(默认=其他)"
        categoryText.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.createTime.mas_bottom)
            make?.left.equalTo()(self.createTime.mas_left)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(119.0)
        }
        
        view.addSubview(categoryBtn)
        categoryBtn.tintColor = .blue
        categoryBtn.setTitleColor(.blue, for: .normal)
        categoryBtn.addTarget(self, action: #selector(selectCategoryAction), for: .touchUpInside)
        categoryBtn.setTitle("选择分类", for: .normal)
        categoryBtn.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.createTime.mas_bottom)
            make?.right.equalTo()(self.view.mas_right)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(100.0)
        }
        
        view.addSubview(remindTimeBtn)
        remindTimeBtn.tintColor = .blue
        remindTimeBtn.setTitleColor(.gray, for: .normal)
        remindTimeBtn.addTarget(self, action: #selector(selectRemindTimeAction), for: .touchUpInside)
        remindTimeBtn.setTitle("选择提醒时间", for: .normal)
        remindTimeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        remindTimeBtn.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.categoryBtn.mas_bottom)
            make?.right.equalTo()(self.categoryBtn.mas_right)
            make?.height.equalTo()(self.categoryBtn)
            make?.width.equalTo()(110.0)
        }
        
        view.addSubview(remindTimeLabel)
        remindTimeLabel.textColor = .gray
        remindTimeLabel.font = UIFont.boldSystemFont(ofSize: 11)
        remindTimeLabel.text = "Choose remind time"
        remindTimeLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.categoryText.mas_left)
            make?.centerY.equalTo()(self.remindTimeBtn)
            make?.height.equalTo()(30.0)
            make?.width.equalTo()(150.0)
        }
    }
    
    @objc func selectCategoryAction() {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: "请选择项目类型", message: nil, preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "服饰", style: .default, handler: { (action) in
                /// 代表0
                self.categoryValue = 0
                self.categoryText.text = "服饰"
            }))
            alertController.addAction(UIAlertAction(title: "食物", style: .default, handler: { (action) in
                /// 代表0
                self.categoryValue = 1
                self.categoryText.text = "食物"
            }))
            alertController.addAction(UIAlertAction(title: "住宿", style: .default, handler: { (action) in
                /// 代表0
                self.categoryValue = 2
                self.categoryText.text = "住宿"
            }))
            alertController.addAction(UIAlertAction(title: "交通", style: .default, handler: { (action) in
                /// 代表0
                self.categoryValue = 3
                self.categoryText.text = "交通"
            }))
            alertController.addAction(UIAlertAction(title: "通讯", style: .default, handler: { (action) in
                /// 代表0
                self.categoryValue = 4
                self.categoryText.text = "通讯"
            }))
            alertController.addAction(UIAlertAction(title: "数码", style: .default, handler: { (action) in
                /// 代表0
                self.categoryValue = 5
                self.categoryText.text = "数码"
            }))
            alertController.addAction(UIAlertAction(title: "其他", style: .cancel, handler: { (action) in
                /// 代表0
                self.categoryValue = 6
                self.categoryText.text = "其他"
            }))
            self.present(alertController, animated: true, completion: {})
        }
    }
    @objc func selectRemindTimeAction() {
        // 选择分类
        let datePicker = UIDatePicker( )
        // 将日期选择器区域设置为中文，则选择器日期显示为中文
        // datePicker.locale = Locale(identifier: "zh_CN")
        // 设置样式，当前设为同时显示日期和时间
        datePicker.datePickerMode = .dateAndTime
        datePicker.calendar = Calendar.current
        // 设置默认时间
        datePicker.date = Date()
        // 响应事件（只要滚轮变化就会触发）
        
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
            alertController.view.layer.masksToBounds = true
            alertController.addAction(UIAlertAction(title: "确定", style: .default) {
                (alertAction)->Void in
                print("date select: \(datePicker.date.description)")
                //获取上一节中自定义的按钮外观DateButton类，设置DateButton类属性thedate
                let fmt = DateFormatter()
                fmt.dateFormat = "yyyy-MM-dd hh:mm:ss"
                self.remindTimeLabel.text = fmt.string(from: datePicker.date)
                self.remindTime = self.remindTimeLabel.text
            })
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel,handler:nil))
            // 初始化 datePicker
            alertController.view.addSubview(datePicker)
            self.present(alertController, animated: true, completion: {
                ///
            })

        } else {
            // Fallback on earlier versions
            // iOS 7系统兼容
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
