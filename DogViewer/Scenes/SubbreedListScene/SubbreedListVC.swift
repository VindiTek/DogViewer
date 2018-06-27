//
//  SubbreedListVC.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit

final class SubbreedListVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl?
    
    //MARK: - Presenter/router
    var presenter: SubbreedListPresenter?
    var router: SubbreedListRouter?
    
    //MARK: - Object life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        SubbreedListConfigurator.configure(self)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        setupTableView()
        setupNavigationBar()
        fetchData()
    }
    
    //MARK: - SetupNavigationBar
    private func setupNavigationBar() {
        navigationItem.title = presenter?.breed
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "See all", style: .plain, target: self, action: #selector(seeAllAction))
    }
    
    //MARK: - SetupTableView
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        guard let presenter = presenter else {return}
        tableView.registerCells(with: presenter.dataSource.cellIdentifiers)
        tableView.delegate = self
        tableView.dataSource = presenter.dataSource
        setupRefreshControl()
    }
    
    //MARK: - Setup RefreshControl
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(reload), for: .valueChanged)
        tableView.backgroundView = refreshControl
    }
    
    //MARK: - Fetch Data
    private func fetchData() {
        presenter?.fetchAllSubbreeds(success: { [weak self] in
            self?.tableView.reloadSections([0], with: .automatic)
            }, failure: { (errorText) in
                print(errorText)
        })
    }
    
    //MARK: - Actions
    @objc private func reload(_ sender: UIRefreshControl) {
        refreshControl?.beginRefreshing()
        presenter?.fetchAllSubbreeds(success: { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
            }, failure: { [weak self] (errorText) in
                self?.refreshControl?.endRefreshing()
                print(errorText)
        })
    }
    
    @objc private func seeAllAction() {
        guard let presenter = presenter else {return}
        router?.openImagesScreen(ofBreed: presenter.breed)
    }
    
}

//MARK: - UITableViewDelegate
extension SubbreedListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let presenter = presenter else {return}
        router?.openImagesScreen(ofBreed: presenter.breed, withSubBreed: presenter.dataSource.subbreed(for: indexPath))
    }
}
