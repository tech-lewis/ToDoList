//
//  NoteEditTextField.swift
//  ToDoList
//
//  Created by MarkLwis on 2021/12/28.
//  Copyright © 2021 mark. All rights reserved.
//

import UIKit

class NoteEditTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var selectFirstMenuIemBlock: (()->Void)?
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let menuController = UIMenuController.shared
        let selectAllItem = UIMenuItem(title: "selectAll", action: #selector(selectAllX(sender:)))
        let selectItem = UIMenuItem(title: "select", action: #selector(selectX(sender:)))
        let copyItem = UIMenuItem(title: "copy", action: #selector(copyX(sender:)))
        let pasteItem = UIMenuItem(title: "paste", action: #selector(pasteX(sender:)))
        let enterEditor = UIMenuItem(title: "编辑器", action: #selector(pushToEditor(sender:)))
        menuController.menuItems = [enterEditor, selectItem, selectAllItem, copyItem, pasteItem]
        
        let result = (action == #selector(selectAllX(sender:)) || action == #selector(selectX(sender:)) || action == #selector(copyX(sender:)) || action == #selector(pasteX(sender:)) || action == #selector(pasteX(sender:)) || action == #selector(pushToEditor(sender:)))
        return result
    }
    
    @objc func selectAllX(sender: Any?)
    {
        selectAll(sender)
    }
    @objc func selectX(sender: Any?)
    {
        select(sender)
    }
    @objc func copyX(sender: Any?)
    {
        copy(sender)
    }
    @objc func pasteX(sender: Any?)
    {
        self.paste(sender)
    }
    @objc func pushToEditor(sender: Any?)
    {
        copy(sender)
        /// 点击了第一项Menu
        guard let block = selectFirstMenuIemBlock else {return}
        block()
    }
}
