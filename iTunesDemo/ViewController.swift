//
//  ViewController.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/3.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var searchBar:UISearchController {
        let resultVC = SearchResultViewController()
        let search = UISearchController(searchResultsController: resultVC)
        search.searchBar.placeholder = "xxxxxxxx"
        search.obscuresBackgroundDuringPresentation = false
        return search
    }
    var titleHeaderView: UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.text = "   收藏夹"
        label.backgroundColor = .white
        return label
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        bindView()
    }
    func setupView() {
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 64
        tableView.sectionHeaderHeight = 48
        tableView.register(MusicCell.nibFromClassName(), forCellReuseIdentifier: "cell")
    }
    func bindView(){
        
    }

}
// MARK: - Delegate
extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        titleHeaderView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}
