//
//  ViewController.swift
//  Song Genius
//
//  Created by Kordian Ledzion on 14.06.2017.
//  Copyright © 2017 KordianLedzion. All rights reserved.
//

import UIKit

class LocalSongsViewController: UIViewController, UITableViewDataSource {
    
    private let sourceIndicatorSwitch = UISwitch()
    fileprivate let searchBar = UISearchBar()
    fileprivate let tableView = UITableView()
    fileprivate let viewModel = SongsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setUpView()
        setUpConstraints()
        setUpTableView()
        setUpSearchBar()
        setUpNavigationBar()
        setUpSourceIndicatorSwitch()
    }
    
    private func setUpSourceIndicatorSwitch() {
        sourceIndicatorSwitch.addTarget(self, action: #selector(switchSource), for: .valueChanged)
    }
    
    @objc private func switchSource() {
        viewModel.switchDataSource(sourceIndicatorSwitch.isOn)
        navigationItem.title = viewModel.navigationItemTitle
        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
    }
    
    private func setUpView() {
        view.backgroundColor = UIColor(r: 244.0, g: 143.0, b: 177.0)
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setUpSearchBar() {
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.barTintColor = UIColor(r: 244.0, g: 143.0, b: 177.0)
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LocalSongsCell.self, forCellReuseIdentifier: "localSongsCell")
        tableView.rowHeight = 48.0
        tableView.contentInset = .zero
    }
    
    private func setUpNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let backButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
        let sortButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(sortBy))
        let sourceIndicatorNavigationButton = UIBarButtonItem.init(customView: sourceIndicatorSwitch)
        navigationItem.rightBarButtonItems = [sortButton, sourceIndicatorNavigationButton]
        navigationItem.title = viewModel.navigationItemTitle
    }
    
    @objc private func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func sortBy() {
        let alertController = UIAlertController(title: "Filters", message:
            "You can choose one way of sorting songs.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "By name", style: .default, handler: { [unowned self] _ in
            self.viewModel.currentSorting.sortingBy = .byName
            self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }))
        
        alertController.addAction(UIAlertAction(title: "By artist", style: .default, handler: { [unowned self] _ in
            self.viewModel.currentSorting.sortingBy = .byArtist
            self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }))
        
        alertController.addAction(UIAlertAction(title: "By year", style: .default, handler: { [unowned self] _ in
            self.viewModel.currentSorting.sortingBy = .byYear
            self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }))
        alertController.addAction(UIAlertAction(title: "Descending", style: .default, handler: { [unowned self] _ in
            self.viewModel.currentSorting.sortingBy = .byName
            self.viewModel.currentSorting.sortingOrder = .descending
            self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }))
        
        alertController.addAction(UIAlertAction(title: "Ascending", style: .default, handler: { [unowned self] _ in
            self.viewModel.currentSorting.sortingOrder = .ascending
            self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }))

        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func dismissKeyboard(){
        view.endEditing(true)
    }
    
    private func setUpConstraints() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
        ])
    }
}

extension LocalSongsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "localSongsCell") as! LocalSongsCell
        let song = viewModel.songs[indexPath.row]
        cell.titleLabel.text = "\(song.artist) - \(song.name)"
        cell.releaseYearLabel.text = song.releaseYear
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = viewModel.songs[indexPath.row]
        let alertController = UIAlertController(title: "Song", message:
            "You've chosen a song \(song.primaryKey) released in \(song.releaseYear != "" ? song.releaseYear : "year only artists knows : (").", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok, cool", style: UIAlertActionStyle.default,handler: nil))
        present(alertController, animated: true, completion: {
            self.tableView.deselectRow(at: indexPath, animated: true)
        })
    }
    
}

extension LocalSongsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchFor(searchText) { result in
            switch result {
            case .success():
                self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
            case .failure(let errorDescription):
                let alertController = UIAlertController(title: "ERROR", message: errorDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
