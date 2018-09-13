//
//  TSOptionsViewController.swift
//  SimpleOptionsList
//
//  Created by CityFruit on 2018/9/13.
//  Copyright © 2018 Stephen Chiang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TSOptionsViewController: UIViewController {
    
    typealias Option = TSOption
    
    typealias BasicCell = UITableViewCell
    
    var allowsMultipleSelection: Bool = false
    
    var showsSearchBar: Bool = false {
        didSet {
            self.tableView.tableHeaderView = self.showsSearchBar ? self.searchBar : nil
        }
    }
    
    let disposeBag = DisposeBag()
    
    var selectedOptions: Variable<[Option]> = Variable.init([])
    
    var selectedOptionCodes: Variable<[String]> = Variable.init([])
    
    var options: Variable<[Option]> = Variable.init([])
    
    var isSearching = Variable<Bool>.init(false)
    
    var searchOptions = Variable<[Option]>.init([])
    
    var didSelectOptionsClosure: (([Option]) -> Void)? = nil
    
    var didSelectOptionClosure: ((Option) -> Void)? = nil
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .done,
                               target: self,
                               action: #selector(doneBarButtonTapped))
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.returnKeyType = .done
        searchBar.placeholder = "搜索"
        searchBar.sizeToFit()
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        if self.showsSearchBar { tableView.tableHeaderView = self.searchBar }
        tableView.register(BasicCell.self, forCellReuseIdentifier: "BasicCell")
        return tableView
    }()
    
    lazy var dataSource: RxTableViewSectionedReloadDataSource<SectionModel> = {
        
        let ds = RxTableViewSectionedReloadDataSource<SectionModel>(configureCell: { [unowned self] ds, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell",
                                                     for: indexPath) as BasicCell
            let selectedItems = self.selectedOptions.value
            let isChecked = selectedItems.contains(where: { $0 == item })
            cell.textLabel?.text = item.name
            if isChecked {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        })
        return ds
    }()
    
    var sections: Variable<[SectionModel]> = Variable.init([])
    
    deinit { print("\(self)_deinit.") }
}

extension TSOptionsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem
        
        self.view.addSubview(self.tableView)

        if #available(iOS 11.0, *) {
            
            let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                self.tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                self.tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                self.tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                self.tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            ])
        } else {
            
            NSLayoutConstraint.activate([
                self.tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor),
                self.tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor),
                self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }
        self.options.asObservable()
            .map { [weak self] _ in self?.toSections() ?? [] }
            .bind(to: self.sections)
            .disposed(by: disposeBag)

        self.sections.asObservable()
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)

        self.selectedOptions.asObservable()
            .map { [weak self] _ in self?.toSections() ?? [] }
            .bind(to: self.sections)
            .disposed(by: disposeBag)
        self.searchOptions.asObservable()
            .map { [weak self] _ in self?.toSections() ?? [] }
            .bind(to: self.sections)
            .disposed(by: self.disposeBag)
        
        // 选中后，取消选中状态
        self.tableView.rx.itemSelected.asObservable()
            .subscribe(onNext: { [weak self] indexPath in
                guard let `self` = self else { return }
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by:self.disposeBag)
        
        // 处理选中添加/移除对应的选项
        self.tableView.rx.modelSelected(Option.self)
            .subscribe(onNext: { [weak self] selectedOption in
                guard let `self` = self else { return }
                let selectedOptions = self.selectedOptions.value
                var options = selectedOptions
                if selectedOptions.contains(selectedOption) {
                    options.po_remove(item: selectedOption)
                } else {
                    if !self.allowsMultipleSelection { options.removeAll() }
                    options.append(selectedOption)
                }
                self.selectedOptions.value = options
            }).disposed(by: self.disposeBag)
        
        // 打印当前选中的选项
        self.selectedOptions.asObservable()
            .subscribe(onNext: { options in print(options) })
            .disposed(by: self.disposeBag)
        
        // 未选择任何选项的时候，完成按钮不可点击
        self.selectedOptions.asObservable()
            .map { !$0.isEmpty }
            .bind(to: self.rightBarButtonItem.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        self.searchBar.rx.searchButtonClicked.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.searchBar.resignFirstResponder()
            })
            .disposed(by: self.disposeBag)

        self.searchBar.rx.text.asObservable()
            .map { $0 == nil ? "" : $0! }
            .map { !$0.isEmpty }
            .bind(to: self.isSearching)
            .disposed(by: self.disposeBag)
        
        self.searchBar.rx.text.asObservable()
            .map { $0 == nil ? "" : $0! }
            .map { [weak self] in self?.filterOptions(searchText: $0) ?? [] }
            .bind(to: self.searchOptions)
            .disposed(by: self.disposeBag)

        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
    }
}

extension TSOptionsViewController {
    
    @objc func doneBarButtonTapped() {
        
        if self.allowsMultipleSelection {
            
            self.didSelectOptionsClosure?(self.selectedOptions.value)
        } else {
            
            if let option = self.selectedOptions.value.first {
                self.didSelectOptionClosure?(option)
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func filterOptions(searchText: String) -> [Option] {
        let options = self.options.value
        return options.filter({ (option) -> Bool in
            return option.name.uppercased().contains(searchText.uppercased())
        })
    }
    
    func toSections() -> [SectionModel] {
        
        let options: [Option]
        
        if self.isSearching.value {
            
            options = self.searchOptions.value
        } else {
            
            options = self.options.value
        }
        let sortedOptions = options.sorted { $0.index > $1.index }
        return [SectionModel(items: sortedOptions)]
    }
    
    func updateSelectedOptions() {
        
        let options = self.options.value
        
        let selectedOptionCodes = self.selectedOptionCodes.value
        
        self.selectedOptions.value = options.filter { selectedOptionCodes.contains($0.code) }
    }
}

extension TSOptionsViewController: UITableViewDelegate {}

extension TSOptionsViewController {
    
    struct SectionModel: SectionModelType {
        
        typealias Item = TSOption
        
        var header: String
        var items: [Item]
        
        init(original: SectionModel, items: [Item]) {
            self = original
            self.items = items
        }
        
        init(header: String = "", items: [Item]) {
            self.header = header
            self.items = items
        }
    }
}
