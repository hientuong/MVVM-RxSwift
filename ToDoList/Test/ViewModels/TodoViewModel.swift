//
//  TodoViewModel.swift
//  Test
//
//  Created by Hien Tuong on 3/6/18.
//  Copyright © 2018 Hien Tuong. All rights reserved.
//

import Foundation
//
//protocol TodoMenuItemPresentable {
//    var title: String? { get }
//    var backColor: String? { get }
//}
//
//protocol TodoMenuItemDelegate{
//    func onMenuItemSelected() -> ()
//}
//
//class TodoMenuItem: TodoMenuItemPresentable, TodoMenuItemDelegate{
//    var title: String?
//    var backColor: String?
//
//    func onMenuItemSelected() {
//        //
//    }
//}
//
//class RemoveMenuItemViewModel: TodoMenuItem {
//    override func onMenuItemSelected() {
//        //
//    }
//}
//
//class DoneMenuItemViewModel: TodoMenuItem{
//    override func onMenuItemSelected() {
//        //
//    }
//}

protocol TodoView: class{
    func insertTodoItem() -> ()
    func removeTodoItem(index: Int) -> ()
}

protocol TodoViewDelegate: class {
    func onAddTodoItem() -> ()
    func onTodoDelete(todoId: String) -> ()
    func onTodoDone(todoId: String) -> ()
}

protocol TodoViewPresentable {
    var newTodoItem: String? { get }
}

class TodoViewModel: TodoViewPresentable {
    weak var delegate: TodoView?
    var newTodoItem: String?
    var items: [TodoItemPresentable] = []
    
    init(delegate: TodoView){
        self.delegate = delegate
        
        let item1 = TodoItem(id: "1", textValue: "Washing Clothes", parentViewModel: self)
        let item2 = TodoItem(id: "2", textValue: "Buy Groceries", parentViewModel: self)
        let item3 = TodoItem(id: "3", textValue: "Wash Car", parentViewModel: self)
        
        items.append(contentsOf: [item1, item2, item3])
    }
}

extension TodoViewModel: TodoViewDelegate{
    
    func onAddTodoItem() {
        
        print("New todo value received in viewmodel : \(newTodoItem)")
        
        guard let newValue = newTodoItem else {
            print("new value is empty")
            return
        }
        
        let itemIndex = items.count + 1
        let newItem = TodoItem(id: "\(itemIndex)", textValue: newValue, parentViewModel: self)
        items.append(newItem)
        newTodoItem = ""
        self.delegate?.insertTodoItem()
    }
   
    func onTodoDelete(todoId: String) {
        print("Remove with Todo index: \(todoId)")
        
        guard let index = self.items.index(where: {$0.id == todoId}) else {
            print("Index for item does not exist")
            return
        }
        
        self.items.remove(at: index)
        self.delegate?.removeTodoItem(index: index)
    }
    
    func onTodoDone(todoId: String) {
        print("Done with Todo index: \(todoId)")
    }
}

