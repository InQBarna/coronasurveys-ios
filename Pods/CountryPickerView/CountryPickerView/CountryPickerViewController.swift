//
//  CountryPickerViewController.swift
//  CountryPickerView
//
//  Created by Kizito Nwose on 18/09/2017.
//  Copyright © 2017 Kizito Nwose. All rights reserved.
//

import UIKit

public class CountryPickerViewController: UITableViewController {
    public var searchController: UISearchController?
    fileprivate var searchResults = [Country]()
    fileprivate var isSearchMode = false
    fileprivate var sectionsTitles = [String]()
    fileprivate var countries = [String: [Country]]()
    fileprivate var hasPreferredSection: Bool {
        dataSource.preferredCountriesSectionTitle != nil &&
            dataSource.preferredCountries.count > 0
    }

    fileprivate var showOnlyPreferredSection: Bool {
        dataSource.showOnlyPreferredSection
    }

    internal weak var countryPickerView: CountryPickerView! {
        didSet {
            dataSource = CountryPickerViewDataSourceInternal(view: countryPickerView)
        }
    }

    fileprivate var dataSource: CountryPickerViewDataSourceInternal!

    override public func viewDidLoad() {
        super.viewDidLoad()

        prepareTableItems()
        prepareNavItem()
        prepareSearchBar()
    }
}

// UI Setup
extension CountryPickerViewController {
    func prepareTableItems() {
        if !showOnlyPreferredSection {
            let countriesArray = countryPickerView.countries
            let locale = dataSource.localeForCountryNameInList

            var groupedData = [String: [Country]](grouping: countriesArray) {
                let name = $0.localizedName(locale) ?? $0.name
                return String(name.capitalized[name.startIndex])
            }
            groupedData.forEach { key, value in
                groupedData[key] = value.sorted(by: { (lhs, rhs) -> Bool in
                    lhs.localizedName(locale) ?? lhs.name < rhs.localizedName(locale) ?? rhs.name
                })
            }

            countries = groupedData
            sectionsTitles = groupedData.keys.sorted()
        }

        // Add preferred section if data is available
        if hasPreferredSection, let preferredTitle = dataSource.preferredCountriesSectionTitle {
            sectionsTitles.insert(preferredTitle, at: sectionsTitles.startIndex)
            countries[preferredTitle] = dataSource.preferredCountries
        }

        tableView.sectionIndexBackgroundColor = .clear
        tableView.sectionIndexTrackingBackgroundColor = .clear
    }

    func prepareNavItem() {
        navigationItem.title = dataSource.navigationTitle

        // Add a close button if this is the root view controller
        if navigationController?.viewControllers.count == 1 {
            let closeButton = dataSource.closeButtonNavigationItem
            closeButton.target = self
            closeButton.action = #selector(close)
            navigationItem.leftBarButtonItem = closeButton
        }
    }

    func prepareSearchBar() {
        let searchBarPosition = dataSource.searchBarPosition
        if searchBarPosition == .hidden {
            return
        }
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.dimsBackgroundDuringPresentation = false
        searchController?.hidesNavigationBarDuringPresentation = searchBarPosition == .tableViewHeader
        searchController?.definesPresentationContext = true
        searchController?.searchBar.delegate = self
        searchController?.delegate = self

        switch searchBarPosition {
        case .tableViewHeader: tableView.tableHeaderView = searchController?.searchBar
        case .navigationBar: navigationItem.titleView = searchController?.searchBar
        default: break
        }
    }

    @objc private func close() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension CountryPickerViewController {
    override public func numberOfSections(in tableView: UITableView) -> Int {
        isSearchMode ? 1 : sectionsTitles.count
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearchMode ? searchResults.count : countries[sectionsTitles[section]]!.count
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: CountryTableViewCell.self)

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CountryTableViewCell
            ?? CountryTableViewCell(style: .default, reuseIdentifier: identifier)

        let country = isSearchMode ? searchResults[indexPath.row]
            : countries[sectionsTitles[indexPath.section]]![indexPath.row]

        var name = country.localizedName(dataSource.localeForCountryNameInList) ?? country.name
        if dataSource.showCountryCodeInList {
            name = "\(name) (\(country.code))"
        }
        if dataSource.showPhoneCodeInList {
            name = "\(name) (\(country.phoneCode))"
        }
        cell.imageView?.image = country.flag

        cell.flgSize = dataSource.cellImageViewSize
        cell.imageView?.clipsToBounds = true

        cell.imageView?.layer.cornerRadius = dataSource.cellImageViewCornerRadius
        cell.imageView?.layer.masksToBounds = true

        cell.textLabel?.text = name
        cell.textLabel?.font = dataSource.cellLabelFont
        if let color = dataSource.cellLabelColor {
            cell.textLabel?.textColor = color
        }
        cell.accessoryType = country == countryPickerView.selectedCountry &&
            dataSource.showCheckmarkInList ? .checkmark : .none
        cell.separatorInset = .zero
        return cell
    }

    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        isSearchMode ? nil : sectionsTitles[section]
    }

    override public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if isSearchMode {
            return nil
        } else {
            if hasPreferredSection {
                return [String](sectionsTitles.dropFirst())
            }
            return sectionsTitles
        }
    }

    override public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        sectionsTitles.firstIndex(of: title)!
    }
}

// MARK: - UITableViewDelegate

extension CountryPickerViewController {
    override public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = dataSource.sectionTitleLabelFont
            if let color = dataSource.sectionTitleLabelColor {
                header.textLabel?.textColor = color
            }
        }
    }

    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = isSearchMode ? searchResults[indexPath.row]
            : countries[sectionsTitles[indexPath.section]]![indexPath.row]

        searchController?.isActive = false
        searchController?.dismiss(animated: false, completion: nil)

        let completion = {
            self.countryPickerView.selectedCountry = country
        }
        // If this is root, dismiss, else pop
        if navigationController?.viewControllers.count == 1 {
            navigationController?.dismiss(animated: true, completion: completion)
        } else {
            navigationController?.popViewController(animated: true, completion: completion)
        }
    }
}

// MARK: - UISearchResultsUpdating

extension CountryPickerViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        isSearchMode = false
        if let text = searchController.searchBar.text, text.count > 0 {
            isSearchMode = true
            searchResults.removeAll()

            var indexArray = [Country]()

            if showOnlyPreferredSection, hasPreferredSection,
                let array = countries[dataSource.preferredCountriesSectionTitle!] {
                indexArray = array
            } else if let array = countries[String(text.capitalized[text.startIndex])] {
                indexArray = array
            }

            searchResults.append(contentsOf: indexArray.filter {
                let name = ($0.localizedName(dataSource.localeForCountryNameInList) ?? $0.name).lowercased()
                let code = $0.code.lowercased()
                let query = text.lowercased()
                return name.hasPrefix(query) || (dataSource.showCountryCodeInList && code.hasPrefix(query))
            })
        }
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension CountryPickerViewController: UISearchBarDelegate {
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Hide the back/left navigationItem button
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Show the back/left navigationItem button
        prepareNavItem()
        navigationItem.hidesBackButton = false
    }
}

// MARK: - UISearchControllerDelegate

// Fixes an issue where the search bar goes off screen sometimes.
extension CountryPickerViewController: UISearchControllerDelegate {
    public func willPresentSearchController(_ searchController: UISearchController) {
        navigationController?.navigationBar.isTranslucent = true
    }

    public func willDismissSearchController(_ searchController: UISearchController) {
        navigationController?.navigationBar.isTranslucent = false
    }
}

// MARK: - CountryTableViewCell.

class CountryTableViewCell: UITableViewCell {
    var flgSize: CGSize = .zero

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame.size = flgSize
        imageView?.center.y = contentView.center.y
    }
}

// MARK: - An internal implementation of the CountryPickerViewDataSource.

// Returns default options where necessary if the data source is not set.
class CountryPickerViewDataSourceInternal: CountryPickerViewDataSource {
    private unowned var view: CountryPickerView

    init(view: CountryPickerView) {
        self.view = view
    }

    var preferredCountries: [Country] {
        view.dataSource?.preferredCountries(in: view) ?? preferredCountries(in: view)
    }

    var preferredCountriesSectionTitle: String? {
        view.dataSource?.sectionTitleForPreferredCountries(in: view)
    }

    var showOnlyPreferredSection: Bool {
        view.dataSource?.showOnlyPreferredSection(in: view) ?? showOnlyPreferredSection(in: view)
    }

    var sectionTitleLabelFont: UIFont {
        view.dataSource?.sectionTitleLabelFont(in: view) ?? sectionTitleLabelFont(in: view)
    }

    var sectionTitleLabelColor: UIColor? {
        view.dataSource?.sectionTitleLabelColor(in: view)
    }

    var cellLabelFont: UIFont {
        view.dataSource?.cellLabelFont(in: view) ?? cellLabelFont(in: view)
    }

    var cellLabelColor: UIColor? {
        view.dataSource?.cellLabelColor(in: view)
    }

    var cellImageViewSize: CGSize {
        view.dataSource?.cellImageViewSize(in: view) ?? cellImageViewSize(in: view)
    }

    var cellImageViewCornerRadius: CGFloat {
        view.dataSource?.cellImageViewCornerRadius(in: view) ?? cellImageViewCornerRadius(in: view)
    }

    var navigationTitle: String? {
        view.dataSource?.navigationTitle(in: view)
    }

    var closeButtonNavigationItem: UIBarButtonItem {
        guard let button = view.dataSource?.closeButtonNavigationItem(in: view) else {
            return UIBarButtonItem(title: "Close", style: .done, target: nil, action: nil)
        }
        return button
    }

    var searchBarPosition: SearchBarPosition {
        view.dataSource?.searchBarPosition(in: view) ?? searchBarPosition(in: view)
    }

    var showPhoneCodeInList: Bool {
        view.dataSource?.showPhoneCodeInList(in: view) ?? showPhoneCodeInList(in: view)
    }

    var showCountryCodeInList: Bool {
        view.dataSource?.showCountryCodeInList(in: view) ?? showCountryCodeInList(in: view)
    }

    var showCheckmarkInList: Bool {
        view.dataSource?.showCheckmarkInList(in: view) ?? showCheckmarkInList(in: view)
    }

    var localeForCountryNameInList: Locale {
        view.dataSource?.localeForCountryNameInList(in: view) ?? localeForCountryNameInList(in: view)
    }
}
