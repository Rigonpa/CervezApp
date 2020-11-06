//
//  BeerDetailViewController.swift
//  CervezApp
//
//  Created by Ricardo González Pacheco on 04/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(DetailImageCell.self, forCellReuseIdentifier: DetailImageCell.cellIdentifier)
        table.register(DetailNameCell.self, forCellReuseIdentifier: DetailNameCell.cellIdentifier)
        table.register(DetailDescCell.self, forCellReuseIdentifier: DetailDescCell.cellIdentifier)
        table.dataSource = self
        table.tableFooterView = UIView()
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    let viewModel: BeerDetailViewModel
    let beerId: String
    init(viewModel: BeerDetailViewModel, beerId: String) {
        self.viewModel = viewModel
        self.beerId = beerId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(handleBackToBeers))
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    override func viewDidLoad() {
        viewModel.viewDidLoad(beerId: beerId)
        
        updateUI()
    }
    
    fileprivate func updateUI() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc fileprivate func handleBackToBeers() {
        viewModel.backToBeersList()
    }
}

extension BeerDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: DetailImageCell.cellIdentifier, for: indexPath) as? DetailImageCell,
            let cellViewModel = viewModel.cellForRowAt(indexPath: indexPath) as? DetailImageCellViewModel {
            cell.viewModel = cellViewModel
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: DetailNameCell.cellIdentifier, for: indexPath) as? DetailNameCell,
            let cellViewModel = viewModel.cellForRowAt(indexPath: indexPath) as? DetailNameCellViewModel {
            cell.viewModel = cellViewModel
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: DetailDescCell.cellIdentifier, for: indexPath) as? DetailDescCell,
            let cellViewModel = viewModel.cellForRowAt(indexPath: indexPath) as? DetailDescCellViewModel {
            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
        
    }
}

extension BeerDetailViewController: BeerDetailViewDelegate {
    func refreshTable() {
        tableView.reloadData()
    }
}
