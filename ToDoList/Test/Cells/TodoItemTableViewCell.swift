//
//  TodoItemTableViewCell.swift
//  Test
//
//  Created by Hien Tuong on 3/6/18.
//  Copyright © 2018 Hien Tuong. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var indexLB: UILabel!
    @IBOutlet weak var todoItemLB: UILabel!
    
    static let Identifier = "TodoItemTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(withViewModel viewModel: TodoItemPresentable) -> (Void){
        indexLB.text = viewModel.id
        todoItemLB.text = viewModel.textValue
    }
}
