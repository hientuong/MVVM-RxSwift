//
//  TodoItem.swift
//  Test
//
//  Created by Hien Tuong on 3/6/18.
//  Copyright © 2018 Hien Tuong. All rights reserved.
//

import Foundation

protocol TodoItemDelegate: class{
    func onItemSelected() -> ()
    func onRemoveSelected() -> ()
    func onDoneSelected() -> ()
}

protocol TodoItemPresentable {
    var id: String? { get }
    var textValue: String? { get }
    var isDone: Bool? { get set }
    var menuItems: [TodoMenuItemPresentable]? {get}
}

class TodoItem: TodoItemPresentable {
    var id: String?
    var textValue: String?
    var isDone: Bool? = false
    var menuItems: [TodoMenuItemPresentable]? = []
    weak var parent: TodoViewDelegate?
    
    init(id: String, textValue: String, parentViewModel: TodoViewDelegate){
        self.parent = parentViewModel
        self.id = id
        self.textValue = textValue
        
        let removeMenuItem = RemoveMenuItem(parentViewModel: self)
        removeMenuItem.title = "Remove"
        removeMenuItem.backColor = "ff0000"
        
        let doneMenuItem = DoneMenuItem(parentViewModel: self)
        doneMenuItem.title = "Done"
        doneMenuItem.backColor = "008000"
        
        menuItems?.append(contentsOf: [removeMenuItem, doneMenuItem])
    }
}

extension TodoItem: TodoItemDelegate {
    func onRemoveSelected() {
        parent?.onTodoDelete(todoId: id!)
    }
    
    func onDoneSelected() {
        parent?.onTodoDone(todoId: id!)
    }
    
    func onItemSelected() {
        print("did selected row at received for item with id = \(id)")
    }
}
