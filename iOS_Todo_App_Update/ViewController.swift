//
//  ViewController.swift
//  iOS_Todo_App_Update
//
//  Created by kiakim on 2023/08/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    
    var numberOfItem = TodoList.data.count
//    var numberOfItem = TodoList.data.count
    
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
        //emptyLabel 관련코드가 이
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
        
        if TodoList.data.count > 0 {
            let todoItem = TodoList.data[indexPath.row]
            cell.configure(with: todoItem)
        } else {
            //Bug 1: (더미)데이터가 없을 경우 아래 로직이 실행 되지 않는 문제
            //cell.configure 쪽으로 로직 옮겨보기 .. !
            print("데이터 없다")
            let emptyLabel: UILabel = {
                let label = UILabel()
                label.text = "추가 된 항목이 없습니다. "
                label.backgroundColor = UIColor.blue
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            cell.contentView.addSubview(emptyLabel)
            
            NSLayoutConstraint.activate([
                emptyLabel.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                emptyLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                emptyLabel.heightAnchor.constraint(equalToConstant: 100),
                emptyLabel.widthAnchor.constraint(equalToConstant: 100)
    
                
                
                
            ])
        }
        
        return cell
    }
    
    
    
    
    @objc func addCell() {
        let alert = UIAlertController(title: "작성하기", message: "할일을 입력하세요", preferredStyle: .alert)
        alert.addTextField {(textField:UITextField) in textField.placeholder = "input todo"}
        
        let addAction = UIAlertAction(title: "완료", style: .default) { [weak self] _ in
            if let textField = alert.textFields?.first,
               let taskText = textField.text,
               // 텍스필드가 비어있지않다면 아래 로직이 실행됩니다.
               !taskText.isEmpty {
        
                //userDefalut에 저장하는 로직 구현, 저장하고 확인하기
                //현재 날짜를 받아오는 부분
                let currentDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM*dd"
                let Date = dateFormatter.string(from: currentDate)
                
                
                UserDefaults.standard.set(Date, forKey: "Key_Date")
                UserDefaults.standard.set(taskText, forKey: "Key_Contents")
                UserDefaults.standard.set(false, forKey: "Key_IsDone")
                
                
                
                // AlertTextField에 입력된 내용을 TodoList의 항목으로
                //생성한 newTodo를 TodoList.data 배열에 추가합니다.
                //지금까지는 여기 코드가 동작했던거군
//                let newTodo = TodoList(contents: taskText, isDone: false)
//                TodoList.data.append(newTodo)
//                for (index,todo) in TodoList.data.enumerated() {
//                    print("\(index). \(todo.contents),  \(todo.isDone)")
//                }
       
                //영호튜터님 멘토링 - 여기부터시작
                //1. 화면에 그려주는 부분이 어딘지 먼저 찾고
                //2. 유져디폴트로 그려주기
                let newTodoData = TodoData(date: currentDate, contents: taskText, isDone: false)
                TodoManager.shared.addTodoItem(date: newTodoData.date, contents: newTodoData.contents)
                
                
                
                
                // numberOfItem(작업 개수)를 업데이트하고 변경 사항을 반영하기 위해 테이블 뷰를 다시 로드합니다.
                self?.numberOfItem += 1
                self?.todoTableview.reloadData()
                
            }
        }
        let cancleAction = UIAlertAction(title: "취소하기", style: .cancel){ (cancel) in
        }
        
        
        alert.addAction(addAction)
        alert.addAction(cancleAction)
        
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        //        TextField에 직접 입력할때
        //        let currentDate = Date()
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "M.dd"
        //        let dateString = dateFormatter.string(from: currentDate)
        //
        //        let newTodo = TodoList(date: dateString, contents: "", isDone: false)
        //        TodoList.data.append(newTodo)
        //        numberOfItem += 1
        //        todoTableview.reloadData()
    }
    
    
}
