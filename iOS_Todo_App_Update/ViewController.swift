//
//  ViewController.swift
//  iOS_Todo_App_Update
//
//  Created by kiakim on 2023/08/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    
    var numberOfItem = 3
    
    var shouldHideTodoView: Bool?{
        didSet{
            guard let shouldHideTodoView = self.shouldHideTodoView else{return}
            self.toDoView.isHidden = shouldHideTodoView
            self.doneView.isHidden = !self.doneView.isHidden
        }
    }
    
    let segmentedControl : UISegmentedControl = {
        let controler = UISegmentedControl(items: ["Todo","Done"])
        let font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        let attributes = [NSAttributedString.Key.font:font]
        controler.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        controler.translatesAutoresizingMaskIntoConstraints = false
        return controler
    }()
    
    let toDoView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가하기", for: .normal)
        button.setTitleColor(UIColor(hex: "187afe"), for:.normal)
        button.layer.borderColor = UIColor(hex: "187afe").cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addCell), for: .touchUpInside)
        return button
    }()
    
    
    let todoTableview: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self,forCellReuseIdentifier: "CustomCell")
        tableView.backgroundColor = UIColor.blue
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let doneView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        
    }


}

extension ViewController{
    
    func configureUI(){
        self.view.addSubview(segmentedControl)
        self.view.addSubview(self.toDoView)
        self.view.addSubview(self.doneView)
        self.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        self.didChangeValue(segment: self.segmentedControl)
        toDoView.addSubview(addButton)
        toDoView.addSubview(todoTableview)
        todoTableview.delegate = self
        todoTableview.dataSource = self
        
        setLayout()
    }
    
    
    func setLayout(){
        NSLayoutConstraint.activate([
            self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            self.segmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.segmentedControl.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            self.toDoView.leftAnchor.constraint(equalTo: self.segmentedControl.leftAnchor),
            self.toDoView.rightAnchor.constraint(equalTo: self.segmentedControl.rightAnchor),
            self.toDoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
            self.toDoView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: toDoView.topAnchor, constant: 30),
            addButton.leftAnchor.constraint(equalTo: toDoView.leftAnchor, constant: 20),
            addButton.rightAnchor.constraint(equalTo: toDoView.rightAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        NSLayoutConstraint.activate([
            todoTableview.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 50),
            todoTableview.leftAnchor.constraint(equalTo: toDoView.leftAnchor, constant: 20),
            todoTableview.rightAnchor.constraint(equalTo: toDoView.rightAnchor, constant: -20),
            todoTableview.bottomAnchor.constraint(equalTo: toDoView.bottomAnchor, constant: 50)
        ])
     
        NSLayoutConstraint.activate([
            self.doneView.leftAnchor.constraint(equalTo: self.toDoView.leftAnchor),
            self.doneView.rightAnchor.constraint(equalTo: self.toDoView.rightAnchor),
            self.doneView.bottomAnchor.constraint(equalTo: self.toDoView.bottomAnchor),
            self.doneView.topAnchor.constraint(equalTo: self.toDoView.topAnchor),
        ])
        
        
        
    }
    
        
    
}

//MARK: Method
extension ViewController{
    @objc private func didChangeValue(segment: UISegmentedControl){
        self.shouldHideTodoView = segment.selectedSegmentIndex != 0
    }
}

//MARK: TableView
extension ViewController: UITextViewDelegate, UITableViewDataSource{
    

    //View가 생성해야할 행의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItem
    }
    
    
    //View에 표현해야 할 내용을 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //재사용이 가능한 셀을 가져오는 tableView 메서드
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
      
        
    let todoItem = TodoList.data[indexPath.row] // 해당 인덱스에 해당하는 TodoList 데이터 가져오기
         cell.configure(with: todoItem) // 셀 구성하기
         return cell
        
    }
    
    @objc func addCell() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M.dd"
        let dateString = dateFormatter.string(from: currentDate)
        
        let newTodo = TodoList(date: dateString, contents: "", isDone: false)
        TodoList.data.append(newTodo)
        numberOfItem += 1
        todoTableview.reloadData()
    }
    
    
}
