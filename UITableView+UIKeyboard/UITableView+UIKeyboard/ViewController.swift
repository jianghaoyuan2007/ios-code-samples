//
//  ViewController.swift
//  UITableView+UIKeyboard
//
//  Created by CityFruit on 2018/9/11.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import IQKeyboardManagerSwift

class ViewController: UIViewController {

    let disposeBag = DisposeBag()

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)
        tableView.register(TSTableViewBasicCell.self,
                           forCellReuseIdentifier: "TSTableViewBasicCell")
        tableView.register(TSTableViewTextViewCell.self,
                           forCellReuseIdentifier: "TSTableViewTextViewCell")
        return tableView
    }()

    lazy var dataSource: RxTableViewSectionedReloadDataSource<TSSectionModel> = {
        
        let ds = RxTableViewSectionedReloadDataSource<TSSectionModel>(configureCell: { ds, tableView, indexPath, item in
            
            switch item {
            case let .basic(title, value):
                let cell = tableView.dequeueReusableCell(withIdentifier: "TSTableViewBasicCell",
                                                         for: indexPath) as! TSTableViewBasicCell
                cell.configure(title: title, value: value, accessoryType: .disclosureIndicator)
                return cell
            case let .textView(title, textView):
                let cell = tableView.dequeueReusableCell(withIdentifier: "TSTableViewTextViewCell",
                                                         for: indexPath) as! TSTableViewTextViewCell
                cell.configure(title: title, textView: textView)
                return cell
            }
        })
        return ds
    }()

    var sections: Variable<[TSSectionModel]> = Variable.init([])
    
    let textView: UITextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        
        self.view.addSubview(self.tableView)
        
        let marginsGuide = self.view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        self.sections.asObservable()
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.modelSelected(TSSectionItem.self)
            .subscribe(onNext: { [weak self](item) in
                guard let `self` = self else { return }
                let vc = UIViewController.init()
                vc.view.backgroundColor = UIColor.white
                vc.title = item.title
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: self.disposeBag)
        
        self.generateSections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = false
    }
}

extension ViewController {
    
    private func generateSections() {
        
        var sections: [TSSectionModel] = []
        
        let titles: [String] = ["姓名", "性别", "年龄", "学校", "班级", "爱好"]
        
        for title in titles {
            sections.append(TSSectionModel(items: [TSSectionItem.basic(title: title, value: "")]))
        }
        
        sections.append(TSSectionModel(items: [TSSectionItem.textView(title: "描述",textView: self.textView)]))
        
        self.sections.value = sections
    }
}

extension ViewController {
    
    enum TSSectionItem {
        case basic(title: String, value: String)
        case textView(title: String, textView: UITextView)
        
        var title: String {
            switch self {
            case let .basic(title, _): return title
            case let .textView(title, _): return title
            }
        }
    }
    
    struct TSSectionModel: SectionModelType {
        
        typealias Item = TSSectionItem
        
        var items: [Item]
        
        init(original: TSSectionModel, items: [Item]) {
            self.items = items
        }
        
        init(items: [Item]) {
            self.items = items
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 5 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
}

