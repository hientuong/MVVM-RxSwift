//
//  TodoMenuItem.swift
//  Test
//
//  Created by Hien Tuong on 3/6/18.
//  Copyright © 2018 Hien Tuong. All rights reserved.
//

import Foundation

protocol TodoMenuItemPresentable {
    var title: String? { get set }
    var backColor: String? { get }
}

protocol TodoMenuItemDelegate {
    func onMenuItemSelected() -> ()
}

class TodoMenuItem: TodoMenuItemPresentable, TodoMenuItemDelegate {
    var title: String?
    var backColor: String?
    weak var parent: TodoItemDelegate?
    
    init(parentViewModel: TodoItemDelegate){
        self.parent = parentViewModel
    }
    
    func onMenuItemSelected() {
        
    }
}

class RemoveMenuItem: TodoMenuItem{
    override func onMenuItemSelected() {
        print("remove Item")
        parent?.onRemoveSelected()
    }
}

class DoneMenuItem: TodoMenuItem{
    override func onMenuItemSelected() {
        print("Done Item")
        parent?.onDoneSelected()
    }
}
