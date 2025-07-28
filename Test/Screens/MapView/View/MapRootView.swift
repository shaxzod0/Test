//
//  MapRootView.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 25/07/25.
//

import UIKit
import YandexMapsMobile

final class MapRootView: UIView {
    
    // MARK: - OUTLETS
    private lazy var locateMeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.icLocate.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(locateMeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var mapView: YMKMapView = YMKMapView()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 8
        searchBar.layer.masksToBounds = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.tintColor = .gray
        searchBar.placeholder = "Search places..."
        return searchBar
    }()
    
    // Search results overlay
    private lazy var searchResultsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchResultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        return tableView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - DEPENDENCIES
    private let viewModel: MapViewModel
    
    // MARK: - LIFECYCLE
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        viewModel.setMapView(mapView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        locateMeButton.layer.cornerRadius = locateMeButton.bounds.width / 2
    }
    
    private func setupUI() {
        clipsToBounds = true
        backgroundColor = .systemBackground
        mapView.translatesAutoresizingMaskIntoConstraints = false
        setupSubviews()
        configureConstraints()
        bindViewModel()
    }
    
    private func setupSubviews() {
        addSubview(mapView)
        addSubview(searchBar)
        addSubview(searchResultsContainer)
        addSubview(locateMeButton)
        
        searchResultsContainer.addSubview(searchResultsTableView)
        searchResultsContainer.addSubview(loadingIndicator)
    }
    
    private func configureConstraints() {
        // Map view
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Search bar
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // Search results container
        NSLayoutConstraint.activate([
            searchResultsContainer.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            searchResultsContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchResultsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchResultsContainer.heightAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
        
        // Search results table view
        NSLayoutConstraint.activate([
            searchResultsTableView.topAnchor.constraint(equalTo: searchResultsContainer.topAnchor),
            searchResultsTableView.leadingAnchor.constraint(equalTo: searchResultsContainer.leadingAnchor),
            searchResultsTableView.trailingAnchor.constraint(equalTo: searchResultsContainer.trailingAnchor),
            searchResultsTableView.bottomAnchor.constraint(equalTo: searchResultsContainer.bottomAnchor)
        ])
        
        // Loading indicator
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: searchResultsContainer.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: searchResultsContainer.centerYAnchor)
        ])
        
        // Locate me button
        NSLayoutConstraint.activate([
            locateMeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            locateMeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
            locateMeButton.widthAnchor.constraint(equalToConstant: 64),
            locateMeButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    @objc private func locateMeButtonTapped() {
        viewModel.locateMe()
    }
    
    func bindViewModel() {
        viewModel.searchResult.bindAndFire { [weak self] result in
            guard let self else { return }
            if !result.isEmpty {
                showSearchResults()
            } else {
                hideSearchResults()
            }
        }
        
        viewModel.showLoading.bindAndFire { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                showLoadingState()
            } else {
                hideLoadingState()
            }
        }
    }
    
    private func showSearchResults() {
        searchResultsContainer.isHidden = false
        searchResultsTableView.reloadData()
        searchResultsContainer.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.searchResultsContainer.alpha = 1
        }
    }
    
    private func hideSearchResults() {
        UIView.animate(withDuration: 0.3) {
            self.searchResultsContainer.alpha = 0
        } completion: { _ in
            self.searchResultsContainer.isHidden = true
        }
    }
    
    private func showLoadingState() {
        searchResultsContainer.isHidden = false
        loadingIndicator.startAnimating()
        searchResultsTableView.isHidden = true
    }
    
    private func hideLoadingState() {
        loadingIndicator.stopAnimating()
        searchResultsTableView.isHidden = false
    }
    
    private func selectSearchResult(_ result: SearchResult) {
        let point = YMKPoint(latitude: result.latitude, longitude: result.longitude)
        let cameraPosition = YMKCameraPosition(target: point, zoom: 16, azimuth: 0, tilt: 0)
        
        mapView.mapWindow.map.move(
            with: cameraPosition,
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1.0),
            cameraCallback: nil
        )
        
        let placemark = mapView.mapWindow.map.mapObjects.addPlacemark(with: point)
        if let pinImage = UIImage(named: "ic_placement") {
            placemark.setIconWith(pinImage)
        }
        searchBar.text = result.name
        searchBar.resignFirstResponder()
        hideSearchResults()
    }
}

// MARK: - UISearchBarDelegate
extension MapRootView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.performSearch(query: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        hideSearchResults()
    }
}

// MARK: - UITableViewDataSource
extension MapRootView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell, let result = viewModel.getItemAt(indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(with: result)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MapRootView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let result = viewModel.getItemAt(indexPath.row) else { return }
        viewModel.showPlaceDetails(result)
        selectSearchResult(result)
    }
}
