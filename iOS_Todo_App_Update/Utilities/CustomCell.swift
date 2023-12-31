//
//  CustomCell.swift
//  iOS_Todo_App_Update
//
//  Created by kiakim on 2023/08/25.
//

import UIKit


class CustomCell: UITableViewCell{
    
    var bringData : TodoData?
    
    let dataArea: UITextField = {
        let view = UITextField()
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 25)
        view.layer.addBorder([.right], color: UIColor.gray, width: 0.5)
        view.textColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        //        view.backgroundColor = UIColor.red
        return view
    }()
    //private 사용이유: 접근제어자 메서드가 호출 될때만 사용되도록
    private func setupDate(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        //값이 변할때마다 동작을 설정
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        //
        dataArea.inputView = datePicker
        //TextField에 오늘 날짜로 표시되게 설정
        dataArea.text = dateFormat(date: Date())
    }
    
    let toDoTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "할일을 입력하세요"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let isDoneButton : UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
    
    let checkIcon : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "checkmark.circle")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // CustomCell을 만들때 작성되는 형식, 초기화 과정을 다루고 있음
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dataArea)
        contentView.addSubview(toDoTextfield)
        contentView.addSubview(isDoneButton)
        isDoneButton.addSubview(checkIcon)
        isDoneButton.addTarget(self, action: #selector(isDoneChange), for: .touchUpInside)
        setupDate()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    func setLayout(){
        NSLayoutConstraint.activate([
            dataArea.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            dataArea.centerYAnchor.constraint(equalTo:
                                                contentView.centerYAnchor),
            dataArea.widthAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            toDoTextfield.leftAnchor.constraint(equalTo: dataArea.rightAnchor, constant: 10),
            toDoTextfield.centerYAnchor.constraint(equalTo:
                                                    contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            isDoneButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            isDoneButton.centerYAnchor.constraint(equalTo:
                                                    contentView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            checkIcon.centerXAnchor.constraint(equalTo:
                                                isDoneButton.centerXAnchor),
            checkIcon.centerYAnchor.constraint(equalTo:
                                                isDoneButton.centerYAnchor)
        ])
        
        
        
    }
    
}

//MARK: Method

extension CustomCell { // 예시로 extension으로 정의했습니다.
    
    
    func configure(with todoItem: TodoData) { // configure 메서드 추가
        bringData = todoItem
        
        toDoTextfield.text = todoItem.contents // TodoList의 contents 값을 설정해줍니다.
        
        if let isDone = todoItem.isDone {
            checkIcon.image = isDone ? UIImage(systemName: "checkmark.circle.fill")
          : UIImage(systemName: "checkmark.circle")
        } else {
            // Handle the case where isDone is nil (provide default styles)
            toDoTextfield.textColor = UIColor.black // or any other color you prefer
        }
        
    }
    
    
    
    @objc func dateChange(_ sender: UIDatePicker){
        //값이 변하면 DatePicker에서 날짜를 받아와 textField에 삽입
        dataArea.text = dateFormat(date: sender.date)
    }
    
    //Bug3 : Index 문제
    @objc func isDoneChange(){
        
        //배열의 첫번째 요소
        if let data = bringData{
            
           
                     if (data.isDone == false){
                         
                data.isDone = true
                TodoManager.shared.saveTodoItemsToUserDefaults()
                checkIcon.image = UIImage(systemName: "checkmark.circle.fill")
                 let attributedString = NSAttributedString(string:toDoTextfield.text ?? "",
                                                          attributes: [
                                                            NSAttributedString.Key.strikethroughStyle:NSUnderlineStyle.single.rawValue])
                toDoTextfield.attributedText = attributedString
                         
                         
            } else {                data.isDone = false
                TodoManager.shared.saveTodoItemsToUserDefaults()
                checkIcon.image = UIImage(systemName: "checkmark.circle")
                    let attributedString = NSAttributedString(string:toDoTextfield.text ?? "")
                toDoTextfield.attributedText = attributedString
            }
            
            
            
            print("Check:,\(String(describing: data.isDone))")
        } else {
            print("nil")
        }
        
        
    }
    
    
    private func dateFormat(date:Date) -> String {
        
        let formtter = DateFormatter()
        formtter.dateFormat = "M.dd"
        
        let savedDate = UserDefaults.standard.string(forKey: "Date")
        //Bug 2 : PickerView에서 date를 수정해도 오늘 날짜로 print 되는 문제
        //  @objc func dateChange + addAction. 로직을 합치면 될것같은데.. ?
        //        print("* 날짜 업데이트 완료: \(savedDate)")
        
        return formtter.string(from: date)
        
    }
    
    
}
