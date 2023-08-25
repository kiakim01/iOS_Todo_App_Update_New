//
//  CustomCell.swift
//  iOS_Todo_App_Update
//
//  Created by kiakim on 2023/08/25.
//

import UIKit


class CustomCell: UITableViewCell{
    
    let dataImgae: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "pencil")
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "description"
        return label
    }()
    
    let toDoTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "할일을 입력하세요"
              textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    // CustomCell을 만들때 작성되는 형식, 초기화 과정을 다루고 있음
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dataImgae)
        contentView.addSubview(toDoTextfield)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    func setLayout(){
        NSLayoutConstraint.activate([
            toDoTextfield.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            toDoTextfield.centerYAnchor.constraint(equalTo:
                            contentView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            dataImgae.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            dataImgae.centerYAnchor.constraint(equalTo:
                            contentView.centerYAnchor)
        ])
    }

}

