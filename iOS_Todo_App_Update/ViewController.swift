//
//  ViewController.swift
//  iOS_Todo_App_Update
//
//  Created by kiakim on 2023/08/24.
//

import UIKit

class ViewController: UIViewController {
    
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
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let doneView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
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
            self.doneView.leftAnchor.constraint(equalTo: self.toDoView.leftAnchor),
            self.doneView.rightAnchor.constraint(equalTo: self.toDoView.rightAnchor),
            self.doneView.bottomAnchor.constraint(equalTo: self.toDoView.bottomAnchor),
            self.doneView.topAnchor.constraint(equalTo: self.toDoView.topAnchor),
        ])
        
        
    }
    
        
    
}


extension ViewController{
    @objc private func didChangeValue(segment: UISegmentedControl){
        self.shouldHideTodoView = segment.selectedSegmentIndex != 0
    }
}
