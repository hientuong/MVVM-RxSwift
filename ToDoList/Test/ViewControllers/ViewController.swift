//
//  ViewController.swift
//  Test
//
//  Created by Hien Tuong on 3/2/18.
//  Copyright © 2018 Hien Tuong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newItemTF: UITextField!
    
    var viewModel : TodoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: TodoItemTableViewCell.Identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TodoItemTableViewCell.Identifier)
        viewModel = TodoViewModel(delegate: self)
    }
    
    @IBAction func onAddItem(_ sender: Any) {
        guard let newTodoValue = newItemTF.text else {
            print("No value entered")
            return
        }
        
        viewModel?.newTodoItem = newTodoValue
        
        self.viewModel?.onAddTodoItem()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoItemTableViewCell.Identifier, for: indexPath) as! TodoItemTableViewCell
        let itemViewModel = viewModel?.items[indexPath.row]
        cell.configure(withViewModel: itemViewModel!)
        return cell
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let itemViewModel: TodoItem = viewModel?.items[indexPath.row] as? TodoItem else { return }
        itemViewModel.onItemSelected()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let itemViewModel = self.viewModel?.items[indexPath.row] as? TodoItem
        
        var menuActions: [UITableViewRowAction] = []
        
        _ = itemViewModel?.menuItems?.map{ menuItem in
            let removeAction = UITableViewRowAction(style: .normal, title: menuItem.title) { [weak self](action, index) in
                guard let `self` = self else { return }
                
                if let delegate = menuItem as? TodoMenuItemDelegate {
                    DispatchQueue.global(qos: .background).async {
                        delegate.onMenuItemSelected()
                    }
                }
                //                self.viewModel?.onDeleteItem(todoId: (itemViewModel?.id)!)
            }
            
            removeAction.backgroundColor = menuItem.backColor!.hexColor
            
            menuActions.append(removeAction)
        }
        
        
        
        return menuActions
    }
}

extension ViewController: TodoView{
    
    func insertTodoItem() {
        print("insert Todo Item")
        
        guard let items = viewModel?.items else { return }
        
        self.newItemTF.text = viewModel?.newTodoItem
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at:  [IndexPath(row: items.count - 1, section: 0)], with: .automatic)
        self.tableView.endUpdates()
        
    }
    
    func removeTodoItem(index: Int) {
        print("delete todo item")
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
    }
}

