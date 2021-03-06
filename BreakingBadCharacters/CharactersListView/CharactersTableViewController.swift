//
//  CharactersTableViewController.swift
//  Breaking Bad Characters
//
//  Created by Evgeni Manchev on 27.01.21.
//

import UIKit
import Kingfisher

class CharactersTableViewController: UITableViewController, UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var indicator = UIActivityIndicatorView().with {
        $0.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        $0.color = .white
        $0.style = UIActivityIndicatorView.Style.large
        $0.backgroundColor = .clear
    }
    
    let blurEffectView = UIVisualEffectView().with {
        $0.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let seasonPicker: UIPickerView = UIPickerView()
    
    var charactersList: Characters = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.blurEffectView.isHidden = true
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                if self.firstVisit {
                    self.seasonPicker.delegate?.pickerView?(self.seasonPicker, didSelectRow: 0, inComponent: 0)
                    self.firstVisit = false
                }
            }
        }
    }
    
    var seasonList: Characters = []
    var filteredList: Characters = []
    
    var selectedCharacter: Character?
    
    var firstVisit: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(blurEffectView)
        view.addSubview(indicator)
        
        navigationController?.navigationBar.topItem?.titleView = seasonPicker
        
        seasonPicker.delegate = self
        seasonPicker.dataSource = self
        
        blurEffectView.frame = view.bounds
        indicator.center = self.view.center
        
        tableView.tableHeaderView = searchController.searchBar
        indicator.startAnimating()
        
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        title = "List of \"Breaking Bad\" characters"
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back", style: .plain, target: nil, action: nil)
        
        ContentManager.requestContent(completionHandler: { (characters) in
            self.charactersList = characters
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredList.removeAll()
        guard searchText.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            self.filteredList = self.seasonList
            tableView.reloadData()
            return
        }
        seasonList.forEach { (character) in
            if character.name.lowercased().range(of: searchText.lowercased()) != nil {
                filteredList.append(character)
                tableView.reloadData()
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = Category.allCases[row].rawValue
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        seasonList.removeAll()
        charactersList.forEach { (character) in
            if character.category.rawValue == Category.allCases[row].rawValue {
                seasonList.append(character)
            }
        }
        filteredList = seasonList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterTableViewCell.height
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        
        cell.characterName.text = filteredList[indexPath.row].name
        if let url = URL(string: filteredList[indexPath.row].img) {
            cell.characterImage.kf.setImage(with: url)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCharacter = filteredList[indexPath.row]
        self.performSegue(withIdentifier: "didSelectRow", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "didSelectRow", let detailsSceen = segue.destination as? CharacterDetailsViewController {
            detailsSceen.character = selectedCharacter
        }
    }
}
