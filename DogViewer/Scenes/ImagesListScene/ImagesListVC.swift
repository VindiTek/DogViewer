//
//  ImagesListVC.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit

final class ImagesListVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl?
    
    //MARK: - Presenter/router
    var presenter: ImagesListPresenter?
    var router: ImagesListRouter?
    
    //MARK: - Object life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        ImagesListConfigurator.configure(self)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        setupTableView()
        setupNavigationBar()
    }
    
    //MARK: - SetupTableView
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        guard let presenter = presenter else {return}
        tableView.registerCells(with: presenter.dataSource.cellIdentifiers)
        tableView.dataSource = presenter.dataSource
        tableView.rowHeight = UIScreen.main.bounds.height / 3
        setupRefreshControl()
    }
    
    //MARK: - SetupRefreshControl
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(reload), for: .valueChanged)
        tableView.backgroundView = refreshControl
    }
    
    //MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        navigationItem.title = presenter?.title
    }
    
    //MARK: - Fetch Data
    private func fetchData() {
        presenter?.fetchData(success: { [weak self] in
            self?.tableView.reloadSections([0], with: .automatic)
            }, failure: { (errorText) in
                print(errorText)
        })
    }
    
    //MARK: - Actions
    @objc private func reload(_ sender: UIRefreshControl) {
        refreshControl?.beginRefreshing()
        presenter?.fetchData(success: { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
            }, failure: { [weak self] (errorText) in
                self?.refreshControl?.endRefreshing()
                print(errorText)
        })
    }
}
