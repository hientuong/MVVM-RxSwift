//
//  TodoViewModel.swift
//  Test
//
//  Created by Hien Tuong on 3/6/18.
//  Copyright © 2018 Hien Tuong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TodoView: class{
    //    func insertTodoItem() -> ()
    //    func removeTodoItem(index: Int) -> ()
    //    func updateTodoItem(at index: Int) -> ()
    //    func reloadItems() -> ()
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
    //    weak var delegate: TodoView?
    var newTodoItem: String?
    var items: Variable<[TodoItemPresentable]> = Variable([])
    
    //    init(delegate: TodoView){
    //        self.delegate = delegate
    //
    //        let item1 = TodoItem(id: "1", textValue: "Washing Clothes", parentViewModel: self)
    //        let item2 = TodoItem(id: "2", textValue: "Buy Groceries", parentViewModel: self)
    //        let item3 = TodoItem(id: "3", textValue: "Wash Car", parentViewModel: self)
    //
    //        items.value.append(contentsOf: [item1, item2, item3])
    //    }
    
    init(){
        //        self.delegate = delegate
        
        let item1 = TodoItem(id: "1", textValue: "Washing Clothes", parentViewModel: self)
        let item2 = TodoItem(id: "2", textValue: "Buy Groceries", parentViewModel: self)
        let item3 = TodoItem(id: "3", textValue: "Wash Car", parentViewModel: self)
        
        items.value.append(contentsOf: [item1, item2, item3])
    }
}

extension TodoViewModel: TodoViewDelegate{
    
    func onAddTodoItem() {
        
        print("New todo value received in viewmodel : \(newTodoItem)")
        
        guard let newValue = newTodoItem else {
            print("new value is empty")
            return
        }
        
        let itemIndex = items.value.count + 1
        
        let newItem = TodoItem(id: "\(itemIndex)", textValue: newValue, parentViewModel: self)
        
        newTodoItem = ""
        
        items.value.append(newItem)
        
        
        
        //        self.delegate?.insertTodoItem()
    }
    
    func onTodoDelete(todoId: String) {
        print("Remove with Todo index: \(todoId)")
        
        guard let index = self.items.value.index(where: {$0.id == todoId}) else {
            print("Index for item does not exist")
            return
        }
        
        self.items.value.remove(at: index)
        //        self.delegate?.removeTodoItem(index: index)
    }
    
    func onTodoDone(todoId: String) {
        print("Done with Todo index: \(todoId)")
        
        guard let index = self.items.value.index(where: {$0.id == todoId}) else {
            print("Index for item done does not exits")
            return
        }
        
        var todoItem = self.items.value[index]
        todoItem.isDone = !(todoItem.isDone)!
        
        if var doneMenuItem = todoItem.menuItems?.filter({ todoMenuItem -> Bool in
            todoMenuItem is DoneMenuItem
        }).first {
            doneMenuItem.title = todoItem.isDone! ? "Undone" : "Done"
        }
        
        self.items.value.sort(by: {
            if !($0.isDone!) && !($1.isDone!) {
                return $0.id! < $1.id!
            }
            
            if $0.isDone! && $1.isDone! {
                return $0.id! < $1.id!
            }
            
            return !($0.isDone!) && $1.isDone!
        })
    }
}

