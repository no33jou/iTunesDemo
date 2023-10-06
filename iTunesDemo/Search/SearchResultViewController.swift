//
//  SearchResultViewController.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/3.
//

import Foundation
import UIKit
import Combine

class SearchResultViewController:UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    let viewModel = SearchViewModel()
    var cancellables:[AnyCancellable] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindView()
    }
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        tableView.rowHeight = 64
        tableView.sectionHeaderHeight = CGFLOAT_MIN
        tableView.register(MusicTableViewCell.nibFromClassName(), forCellReuseIdentifier: "cell")
        
    }
    func bindView() {
        viewModel.$displayList.receive(on: RunLoop.main).sink { [weak self] _ in
            guard let this = self else { return }
            this.tableView.reloadData()
        }.store(in: &cancellables)
        
        viewModel.$showLoading.sink { [weak self] in
            guard let this = self else { return }
            if $0 {
                this.activityView.startAnimating()
            }else{
                this.activityView.stopAnimating()
            }
        }.store(in: &cancellables)
        
    }
}

// MARK: - Delegate
extension SearchResultViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.keywork = searchBar.text
        viewModel.fetchData()
    }
}
extension SearchResultViewController:UITableViewDelegate, UITableViewDataSource,UITableViewDataSourcePrefetching{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MusicTableViewCell ?? MusicTableViewCell()
        cell.viewModel = viewModel.displayList[indexPath.row]
        cell.cancellable?.cancel()
        cell.cancellable = cell.tapPubluic.sink(receiveValue: {[weak self] deta in
            guard let this = self else { return }
        
        })
        return cell
    }
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // 当选择中筛选方式后无法加载更多数据
        if viewModel.selectMediaType != nil{
            return
        }
        // 判断是否需要触发分页请求
        let needMoreLoad = indexPaths.contains {$0.row >= viewModel.displayList.count-1}
        guard needMoreLoad else {
            return
        }
        self.viewModel.fetchMoreData()
    }
}

