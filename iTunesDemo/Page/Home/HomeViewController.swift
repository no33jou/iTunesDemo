//
//  HomeViewController.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/3.
//

import UIKit
import Combine
class HomeViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var searchBar: UISearchController {
        let resultVC = SearchResultViewController()
        let search = UISearchController(searchResultsController: resultVC)

        search.searchBar.placeholder = "xxxxxxxx"
        search.obscuresBackgroundDuringPresentation = false
        search.delegate = self
        
        search.searchBar.delegate = resultVC
        return search
    }
    
    var titleHeaderView: UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.text = "   收藏夹"
        label.backgroundColor = .white
        return label
    }
    var viewModel = BookmarkViewModel()
    var cancellables:[AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        bindView()
        viewModel.loadData()
    }
    func setupView() {
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 64
        tableView.sectionHeaderHeight = 48
        tableView.register(MusicTableViewCell.nibFromClassName(), forCellReuseIdentifier: "cell")
    }

    func bindView() {
        viewModel.$displayData.receive(on: RunLoop.main).sink { [weak self] _ in
            self?.tableView.reloadData()
        }.store(in: &cancellables)
    }
}

// MARK: - Delegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.displayData.isEmpty ? 0:1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        titleHeaderView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MusicTableViewCell
        cell.viewModel = viewModel.displayData[indexPath.row]
        cell.cancellable?.cancel()
        cell.cancellable = cell.tapPubluic.sink(receiveValue: { [weak self] vm in
            guard let this = self else { return  }
            this.viewModel.remove(index: indexPath.row)
        })
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = viewModel.displayData[indexPath.row]
        if let url = vm.viewURL,UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
        }
    }
}
extension HomeViewController:UISearchControllerDelegate{
    func willDismissSearchController(_ searchController: UISearchController) {
        viewModel.loadData()
    }
}
