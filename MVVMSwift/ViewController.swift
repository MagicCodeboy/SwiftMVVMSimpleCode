//
//  ViewController.swift
//  MVVMSwift
//
//  Created by lalala on 2017/3/31.
//  Copyright © 2017年 lsh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var textView: TextView = {
        let view = TextView.init(viewModel: self.textViewModel)
        view.frame = UIScreen.main.bounds
        return view
    }()
    private lazy var textViewModel: TextViewModel = {
        let model = TextViewModel()
        return model
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textView)
        print(textViewModel.textModel.colorName!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

