//
//  NewTaskViewController.swift
//  MjeedTo-Do-LIst
//
//  Created by Abdullmajeed Alamri on 09/11/2020.
//

import UIKit

protocol NewTaskViewControllerDelegate: class {
    func addTask(task: Task)
    func updateTask(task: Task , indexpath: IndexPath)
}

class NewTaskViewController : UIViewController{
    
    var task : Task?
    var indexPath: IndexPath?
    
    weak var delegate : NewTaskViewControllerDelegate?
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Task Title"
        textField.textAlignment = .center
        textField.textColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.font = UIFont(name: "GeezaPro", size: 12)
        textField.adjustsFontSizeToFitWidth = true
        textField.setDimensions(height: 40, width: UIScreen.main.bounds.width / 2)
        textField.layer.borderColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        textField.layer.borderWidth = 1
        return textField
    }()
    
     var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Task Title: "
        label.setHeight(height: 40)
        label.textColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var dueDate : UIDatePicker = {
        let dueDate = UIDatePicker()
        dueDate.isEnabled = true
        dueDate.tintColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        return dueDate
    }()
    
    var additionalTextView: UITextView = {
        let text = UITextView()
        text.textAlignment = .center
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.backgroundColor = #colorLiteral(red: 0.1563676894, green: 0.1678637564, blue: 0.2093632221, alpha: 1)
        text.textColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        text.layer.borderColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        text.layer.borderWidth = 3
        text.layer.cornerRadius = 20
        text.setDimensions(height: 200, width: UIScreen.main.bounds.width - 50)
        return text
    }()
    
    var dueDateSwitch : UISwitch = {
        let switchy = UISwitch()
        switchy.setOn(true, animated: true)
        switchy.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        switchy.tintColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        switchy.onTintColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 0.5)
        switchy.thumbTintColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        return switchy
    }()
    
    let viewButton : UIButton = {
        var button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.setDimensions(height: 60, width:  UIScreen.main.bounds.width - 80)
        button.layer.cornerRadius = 30
        button.setTitle("Add Task", for: .normal)
        button.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
        return button
    }()
    
    let createdDate : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        return label
    }()
    
//    lazy var titleStackView : UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleTextField])
//        stackView.axis = .
//        return  stackView
//
//    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateTaskWhenVisited()
        
    }
    
    func updateTaskWhenVisited() {
        guard let task = task else { return }
        viewButton.tag = 1
        viewButton.setTitle("Edit task", for: .normal)
        titleTextField.text = task.taskTitle
        additionalTextView.text = task.additionalInfo
        guard let dueDate = task.dueDate else { return }
        self.dueDate.date = dueDate
        dueDateSwitch.isOn = true
    }
    
    
    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.1563676894, green: 0.1678637564, blue: 0.2093632221, alpha: 1)
        
        view.addSubview(titleTextField)
        titleTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              right: view.rightAnchor ,
                              paddingTop: 20,
                              paddingRight: 20)
        
        view.addSubview(titleLabel)
        titleLabel.centerY(inView: titleTextField)
        titleLabel.anchor(left: view.leftAnchor,
                          right: titleTextField.leftAnchor,
                          paddingLeft: 30)
  
        view.addSubview(dueDateSwitch)
        dueDateSwitch.anchor(top: titleTextField.bottomAnchor,
                             right: view.rightAnchor,
                             paddingTop: 30,
                             paddingRight: 30)
        
        view.addSubview(dueDate)
        dueDate.centerX(inView: view,
                        topAnchor: dueDateSwitch.bottomAnchor)
        
        view.addSubview(additionalTextView)
        additionalTextView.centerX(inView: view,
                                   topAnchor: dueDate.bottomAnchor,
                                   paddingTop: 30)
        
        view.addSubview(createdDate)
        createdDate.anchor(top: additionalTextView.bottomAnchor,
                           left: view.safeAreaLayoutGuide.leftAnchor,
                           paddingTop: 10,
                           paddingLeft: 5)
        
        view.addSubview(viewButton)
        viewButton.centerX(inView: view,
                           topAnchor: createdDate.bottomAnchor,
                           paddingTop: 30)
    }
    
    
    @objc func handleSwitch() {
        if dueDateSwitch.isOn {
            dueDate.isEnabled = true
            
        } else {
            dueDate.isEnabled = false
        }
    }
    
    @objc func handleButton(_ tag: UIButton) {
        if titleTextField.text!.isEmpty {
            let alert = UIAlertController(title: nil, message: "Please type the task title.😗", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (_) in}
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let title = titleTextField.text else { return }
        guard let additonalInfo = additionalTextView.text else { return }
         
        let task = Task(taskTitle: title, dueDate: dueDateSwitch.isOn ? dueDate.date : nil, createdDate: Date() , additionalInfo: additonalInfo, isCompleted: false)
        
        switch tag.tag {
        case 0:
            delegate?.addTask(task: task)
            print("tag is 0")
            navigationController?.popToRootViewController(animated: true)
        case 1:
            guard let indexPath = indexPath else {return}
            
            print("tag is 1")
            delegate?.updateTask(task: task, indexpath: indexPath)
            navigationController?.popToRootViewController(animated: true)
        default:
            break
        }
    }
}
