//
//  AllDogsBreedListVC.swift
//  DogViewer
//
//  Created by Dmytro Antonchenko on 6/27/18.
//  Copyright © 2018 Dmytro Antonchenko. All rights reserved.
//

import UIKit

final class AllDogsBreedListVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl?
    
    //MARK: - Presenter/router
    var presenter = AllDogsBreedListPresenter()
    var router: AllDogsBreedListRouter?
    
    //MARK: - Object life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        AllDogsBreedListConfigurator.configure(self)
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
    }
    
    //MARK: - Configure TableView
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.registerCells(with: presenter.dataSource.cellIdentifiers)
        tableView.delegate = self
        tableView.dataSource = presenter.dataSource
        setupRefreshControl()
    }
    
    //MARK: - SetupRefreshControl
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.backgroundView = refreshControl
    }
    
    //MARK: - Fetch Data
    private func fetchData() {
        presenter.fetchData(success: { [weak self] in
            self?.tableView.reloadSections([0], with: .automatic)
        }) { (errorText) in
            print(errorText)
        }
    }
    
    //MARK: - Actions
    @objc private func refresh(_ sender: UIRefreshControl) {
        refreshControl?.beginRefreshing()
        presenter.fetchData(success: { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        }) { [weak self] (errorText) in
            print(errorText)
            self?.refreshControl?.endRefreshing()
        }
    }
    
}

//MARK: - UITableViewDelegate
extension AllDogsBreedListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let breed = presenter.dataSource.dogBreed(for: indexPath)
        if breed.subBreed.isEmpty {
            router?.openImagesScreen(ofBreed: breed.name)
        } else {
            router?.openSubbreedsScreen(ofBreed: breed.name, andSubbreeds: breed.subBreed)
        }
    }
}
