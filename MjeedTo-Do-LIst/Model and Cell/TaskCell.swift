//
//  TaskCell.swift
//  MjeedTo-Do-LIst
//
//  Created by Abdullmajeed Alamri on 09/11/2020.
//

import UIKit

class TaskCell: UITableViewCell {
    
    var taskTitle : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.setWidth(width: 180)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.setupShadow(opacity: 1, radius: 0.5, offset: CGSize(width: 1, height: 1), color: #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1))
        return label
    }()
    
    var taskDueDate : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.setupShadow(opacity: 1, radius: 0.5, offset: CGSize(width: 1, height: 1), color: #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1))
        return label
    }()
    
    var checkmarkBTN: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.tintColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        contentView.addSubview(checkmarkBTN)
        checkmarkBTN.centerY(inView: self)
        checkmarkBTN.anchor(right: self.safeAreaLayoutGuide.rightAnchor, paddingRight: 20)
        let stackView = UIStackView(arrangedSubviews: [taskTitle, taskDueDate])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 20)
        stackView.anchor(right: checkmarkBTN.leftAnchor, paddingRight: 10)
        
        
//        addSubview(taskDueDate)
//        taskDueDate.centerY(inView: self)
//        taskDueDate.anchor(right: checkmarkBTN.leftAnchor, paddingRight: 30)
//
//        addSubview(taskTitle)
//        taskTitle.centerY(inView: self)
//        taskTitle.anchor(left: self.leftAnchor, right: taskDueDate.leftAnchor, paddingLeft: 25, paddingRight: 10)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func setCell(task: Task) {
        taskTitle.text = task.taskTitle
        let dueDateString = task.dueDate?.convertDate(formattedString: .formattedType4)
        taskDueDate.text = dueDateString
    }
}
