//
//  ViewController.swift
//  MjeedTo-Do-LIst
//
//  Created by Abdullmajeed Alamri on 09/11/2020.
//

import UIKit
// Identifier for the cell
private let cellID = "TaskCell"

class ViewController: UIViewController {
    
    var taskStore : TaskStore!
    var filterTask: [Task] = []
    
    
    var dynamicHeight: CGFloat {
        return UIScreen.main.bounds.height < 800 ? 150 : 200
    }
    
    
    lazy var topContainer: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1563676894, green: 0.1678637564, blue: 0.2093632221, alpha: 1)
        view.setDimensions(height: 170, width: UIScreen.main.bounds.width)
        view.layer.borderWidth = 0
        
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    lazy var todayContainerView: UIView = {
        let todayContainer = UIView()
        todayContainer.setDimensions(height: 10, width: 170)
        todayContainer.backgroundColor = #colorLiteral(red: 0.1482841671, green: 0.1678923965, blue: 0.2094292343, alpha: 1)
        todayContainer.roundCorners(corners: [.topRight, .bottomLeft], radius: 20)
        todayContainer.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        todayContainer.layer.borderWidth = 3
        todayContainer.setupShadow(opacity: 1.0 , radius: 20, color: #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1))
        return todayContainer
    }()
    
    lazy var monthLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        label.setDimensions(height: 30, width: 170)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "No Tasks 🤗"
        label.textAlignment = .center
        label.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.roundCorners(corners: [.topRight], radius: 20)
        label.layer.borderWidth = 3
        if taskStore.alltasks.isEmpty == false {
            let task = taskStore.alltasks[0]
            label.text = task.dueDate?.convertDate(formattedString: .formattedType10)
            label.adjustsFontSizeToFitWidth = true
        }
        return label
    }()
    
    lazy var nextTaskTitle: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "🥳"
        if taskStore.alltasks.isEmpty == false {
            label.adjustsFontSizeToFitWidth = true
            let task = taskStore.alltasks[0]
            label.text = task.taskTitle
        }
        return label
    }()
    
    
    lazy var welcomeLabel : UILabel = {
        let label = UILabel()
        label.text = " Hello! \n Your Next Task Is:"
        label.numberOfLines = 2
        label.textColor = .white
        label.roundCorners(corners: [.topLeft, .bottomRight], radius: 20)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = .clear
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        label.setupShadow(opacity: 2, radius: 1, offset: CGSize(width: 2, height: 2), color: #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1))
        
        label.textAlignment = .left
        label.setDimensions(height: 60, width: 170)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableView.roundCorners(corners: [.topLeft], radius: 80)
        tableView.clipsToBounds = true
        tableView.separatorColor = .white
                return tableView
    }()
    
    let newTaskBTN: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(height: 50 , width: 50)
        button.layer.cornerRadius = 25
        button.backgroundColor = #colorLiteral(red: 0.1563676894, green: 0.1678637564, blue: 0.2093632221, alpha: 1)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        button.addTarget(self, action: #selector(handleAddingTask), for: .touchUpInside)
        button.setupShadow(opacity: 1, radius: 20,  color: #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1))
        return button
    }()
    
    
    
    let searchField = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationBar()
    }
    
    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.1563676894, green: 0.1678637564, blue: 0.2093632221, alpha: 1)
        view.addSubview(topContainer)
        topContainer.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        
        topContainer.addSubview(todayContainerView)
        todayContainerView.centerY(inView: topContainer)
        todayContainerView.anchor(top: topContainer.topAnchor , bottom: topContainer.bottomAnchor , right: topContainer.rightAnchor,paddingTop: 60 , paddingBottom: 15, paddingRight: 20)
        
        topContainer.addSubview(welcomeLabel)
        welcomeLabel.anchor(top: topContainer.topAnchor, left: topContainer.leftAnchor, paddingTop: 10, paddingLeft: 10)
        
        todayContainerView.addSubview(monthLabel)
        todayContainerView.addSubview(nextTaskTitle)
        nextTaskTitle.centerInSuperview()
        
        view.addSubview(tableView)
        tableView.anchor(top: topContainer.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        tableView.rowHeight = 60
        
        view.addSubview(newTaskBTN)
        newTaskBTN.anchor(bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: 40, paddingRight: 20)
    }
    
    func configureNavigationBar() {
        configureNavigationBar(withTitle: "Mjeed's List", largeTitleColor: .white, tintColor: #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1), smallTitleColorWhenScrolling: .light, prefersLargeTitles: true)
        navigationController?.navigationBar.setupShadow(opacity: 1.0, radius: 20, color: #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1))
        
        navigationItem.searchController = searchField
        searchField.obscuresBackgroundDuringPresentation = false
        searchField.searchBar.placeholder = "Search for task"
        searchField.searchResultsUpdater = self
        searchField.searchBar.tintColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        searchField.searchBar.barTintColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        searchField.searchBar.searchTextField.textColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        searchField.searchBar.setupShadow(opacity: 1, radius: 2, offset: CGSize(width: 1, height: 1), color: #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1))
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(showEditing(_:)))
        navigationItem.rightBarButtonItem = editButton
        
        let backButton = UIBarButtonItem()
        backButton.title = "Mjeed's List"
        navigationItem.backBarButtonItem = backButton
        definesPresentationContext = true
    }
    
    @objc func showEditing(_ sender: UIBarButtonItem)
    {
        if(self.tableView.isEditing == true)
        {
            tableView.fadeIn()
            self.tableView.isEditing = false
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        }
        else
        {
            tableView.fadeIn()
            self.tableView.isEditing = true
            self.navigationItem.rightBarButtonItem?.title = "Done"
        }
    }
    
    //    func usersName() {
    //        let alert = UIAlertController(title: nil, message: "What is Yout Name?", preferredStyle: .alert)
    //        let action = UIAlertAction(title:nil, style: .default) { (<#UIAlertAction#>) in
    //            <#code#>
    //        }
    //
    //    }
    
    //    func nextTask() {
    //        let task = taskStore.alltasks[0]
    //        monthLabel.text = task.dueDate.convertDate(formattedString: .formattedType10)
    //    }
    
    
    @objc func handleAddingTask() {
        let newTaskViewController = NewTaskViewController()
        newTaskViewController.delegate = self
        newTaskViewController.dueDate.minimumDate = Date()
        navigationController?.pushViewController(newTaskViewController, animated: true)
    }
}



extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchField.isActive ? filterTask.count : taskStore.alltasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TaskCell
        let task = searchField.isActive ? filterTask[indexPath.row] : taskStore.alltasks[indexPath.row]
        cell.checkmarkBTN.setDimensions(height: 30, width: 30)
        cell.checkmarkBTN.setImage(UIImage(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle"), for: .normal)
        cell.setCell(task: task)
        
        guard let dueDate = task.dueDate else { return cell }
        let taskDueDate = task.dueDate?.convertDate(formattedString: .formattedType4)
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.month, .day, .hour], from: dueDate, to: Date())
        if comp.hour! >= 0 && comp.day != 0 {
            cell.taskDueDate.textColor = .red
            cell.taskDueDate.text = "You'r \(abs(comp.day!)) day(s) behind. (\(taskDueDate!)) "
        }
        if comp.day! == 0 && comp.hour! >=  0 && comp.hour! > 23 {
            cell.taskDueDate.textColor = .yellow
            cell.taskDueDate.text = "After \(abs(comp.hour!)) hours. (\(taskDueDate!)) "
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = searchField.isActive ? filterTask[indexPath.row] : taskStore.alltasks[indexPath.row]
        let vc = NewTaskViewController()
        vc.title = selectedCell.taskTitle
        vc.task = selectedCell
        vc.indexPath = indexPath
        vc.delegate = self
        if selectedCell.dueDate == nil {
            vc.dueDate.isEnabled = false
            vc.dueDate.minimumDate = Date()
            vc.dueDateSwitch.isOn = false
        } else {
            vc.dueDate.date = selectedCell.dueDate!
        }
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = searchField.isActive ? filterTask[indexPath.row] : taskStore.alltasks[indexPath.row]
            taskStore.removeTask(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        if taskStore.alltasks.isEmpty {
            nextTaskTitle.fadeIn()
            monthLabel.fadeIn()
            nextTaskTitle.text = "No Tasks 🤗"
            monthLabel.text = "🥳"
        } else {
            let task = taskStore.alltasks[0]
            nextTaskTitle.text = task.taskTitle
            monthLabel.text = task.dueDate?.convertDate(formattedString: .formattedType10)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        taskStore.movetask(from: sourceIndexPath.row, to: destinationIndexPath.row)
        let task  = taskStore.alltasks[0]
        nextTaskTitle.fadeIn()
        monthLabel.fadeIn()
        nextTaskTitle.text = task.taskTitle
        monthLabel.text = task.dueDate?.convertDate(formattedString: .formattedType10)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var selectedTask = searchField.isActive ? filterTask[indexPath.row] : taskStore.alltasks[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Completed") { [self] (action, view, completion) in
            selectedTask.isCompleted = !selectedTask.isCompleted
            taskStore.alltasks[indexPath.row] = selectedTask
            tableView.reloadData()
        }
        action.backgroundColor = #colorLiteral(red: 0.002793717897, green: 0.6510958672, blue: 0.7109569311, alpha: 1)
        let config = UISwipeActionsConfiguration(actions: [action])
        config.performsFirstActionWithFullSwipe = false
        return config
    } 
}

extension ViewController: NewTaskViewControllerDelegate {
    func addTask(task: Task) {
        taskStore.alltasks.insert(task, at: 0)
        nextTaskTitle.text = task.taskTitle
        monthLabel.text = task.dueDate?.convertDate(formattedString: .formattedType10)
        tableView.reloadData()
    }
    
    func updateTask(task: Task, indexpath: IndexPath) {
        taskStore.alltasks[indexpath.row] = task
        tableView.reloadRows(at: [indexpath], with: .automatic)
        if task == taskStore.alltasks[0] {
            nextTaskTitle.text = task.taskTitle
            monthLabel.text = task.dueDate?.convertDate(formattedString: .formattedType10)
        }
        tableView.reloadData()
    }
    
    
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchedTask = searchController.searchBar.text else { return }
        filterTask = taskStore.alltasks.filter({ (task) -> Bool in
            return task.taskTitle.lowercased().contains(searchedTask.lowercased())
        })
        tableView.reloadData()
    }
}
