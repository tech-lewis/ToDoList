//
//  AddNewNoteEditorController.swift
//  ToDoList
//
//  Created by MarkLwis on 2021/12/28.
//  Copyright © 2021 mark. All rights reserved.
//

import UIKit

class AddNewNoteEditorController: UIViewController {
    
    private let customTextView = ComposeTextView()
    private let hideKeyboardItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hideKeyboardAction))
    private let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    private var bottomToolbar = UIToolbar()
    public var finishEditingBlock: ((String)->Void)?
    @objc func saveAction () {
        guard let block = finishEditingBlock, customTextView.text.count > 0  else {
            let alert = UIAlertView(title: "温馨提示", message: "您未输入详情文本", delegate: nil, cancelButtonTitle: "Done")
            alert.show()
            return;
        }
        
        dismiss(animated: true) {
            block(self.customTextView.text)
        }
    }
    
    @objc func closeController () {
        dismiss(animated: true, completion: nil)
    }
    @objc func hideKeyboardAction () {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
    }
    
    func setupUI() {
        guard let statusHeight =  navigationController?.navigationBar.frame.size.height else {return}
        guard let backgroundImage = UIImage(named: "homeBG") else {return}
        view.backgroundColor = UIColor.init(patternImage: backgroundImage)


        title = "富文本编辑器"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        view.addSubview(customTextView)
        let lb = UILabel()
        customTextView.font = lb.font
        customTextView.backgroundColor = .clear
        customTextView.mas_makeConstraints { make in
            make?.top.equalTo()(UIApplication.shared.statusBarFrame.size.height + statusHeight)
            make?.left.right().equalTo()(self.view)
        }
        
        
        
        bottomToolbar.items = [flexibleSpaceItem, hideKeyboardItem]
        // customTextView.inputAccessoryView = bottomToolbar
        view.addSubview(bottomToolbar)
        bottomToolbar.mas_makeConstraints { make in
            make?.width.equalTo()(self.view)
            make?.height.equalTo()(34.0)
            make?.left.right().bottom().equalTo()(self.view)
            make?.top.equalTo()(self.customTextView.mas_bottom)
        }
        // 1.设置textView代理
        customTextView.delegate = self
        
        // 2.监听键盘变化
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(note:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    // MARK: - 内部控制方法
    @objc private func keyboardWillChange(note: NSNotification)
    {
        // 获取键盘弹出和退出的时间
        let durationTime = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        // 获取和底部的差距
        
        
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue;
        var margin = view.frame.size.height - endFrame.origin.y
        //IPX -34
        if margin>0
        {
            margin = margin-34.0
            
            // 键盘出现
            bottomToolbar.items = [flexibleSpaceItem, hideKeyboardItem]
        }
        else
        {
            bottomToolbar.items = []
        }
        // 改变约束,并且执行动画
        
        bottomToolbar.mas_updateConstraints { make in
            make?.bottom.mas_equalTo()(-margin-34)
        }
        
        
        
        //toolBarBottomCons.constant = margin
        UIView.animate(withDuration: durationTime) {
        // 如果执行多次动画,则忽略上一次已经未完成的动画,直接进入下一次
        UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            print(self.bottomToolbar.frame)
            self.view.layoutIfNeeded()
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

extension AddNewNoteEditorController: UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView) {
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        customTextView.resignFirstResponder()
    }
}
