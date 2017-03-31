//
//  TextView.swift
//  MVVMSwift
//
//  Created by lalala on 2017/3/31.
//  Copyright © 2017年 lsh. All rights reserved.
//

import UIKit

class TextView: UIView {
    
    fileprivate lazy var button: UIButton = {
        let btn = UIButton.init(type: .system)
        btn.frame = CGRect(x: 0,y: 0, width: 100,height: 100)
        btn.setTitle("换装", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.titleLabel?.textColor = UIColor.black
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        return btn
    }()
    
    var textViewModel = TextViewModel()
    init(viewModel: TextViewModel) {
         super.init(frame: CGRect(x: 0,y: 0, width: 100,height: 100))
        textViewModel = viewModel
        //添加子视图
        setupSubViews()
        //绑定viewModel 使用 通知 or KVO
        bindingViewModel()
        //请求数据
        textViewModel.requestData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
         textViewModel.removeObserver(self, forKeyPath: "color")
    }
}

private var myContext = 0
fileprivate extension TextView {
    func setupSubViews()  {
        addSubview(button)
    }
    func bindingViewModel() {
        //使用通知 通知color属性的变化
//NotificationCenter.default.addObserver(forName: NSNotification.Name.init(rawValue: KTextViewUpdateUI), object: nil, queue: OperationQueue.main) {  in
//        }
         //使用KVO监听color属性的变化
        textViewModel.addObserver(self, forKeyPath: "color", options: [.old, .new], context: &myContext)
    }
    @objc func buttonDidClick() {
        textViewModel.requestData()
    }
}
extension TextView {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "color" {
            backgroundColor = textViewModel.color
        }
    }
}
