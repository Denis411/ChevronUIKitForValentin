//
//  ViewController.swift
//  ChevronUIKit
//
//  Created by Dennis Loskutov on 07.07.2022.
//

import UIKit

class Chevron {
    let title: String
    let options: [String]
    var isOpened = false
    
    init(title: String, options: [String], isOpened: Bool = false) {
        self.title = title
        self.options = options
        self.isOpened = isOpened
    }
    
    static let fakeSections = [ Chevron(title: "Chevron First", options: Array(1..<10).compactMap{ "Cell number: \($0)"}),
                                Chevron(title: "Chevron Second", options: Array(1..<10).compactMap{ "Cell number: \($0)"}),
                                Chevron(title: "Chevron Third", options: Array(1..<10).compactMap{ "Cell number: \($0)"}),
                                Chevron(title: "Chevron Fourth", options: Array(1..<10).compactMap{ "Cell number: \($0)"}),
                                Chevron(title: "Chevron Fifth", options: Array(1..<10).compactMap{ "Cell number: \($0)"})]
}

class ViewController: UIViewController {
    private let chevrons = Chevron.fakeSections
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.backgroundColor = .yellow
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        chevrons.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSection = chevrons[section]
        
        if currentSection.isOpened {
//            + 1 for section title
            return currentSection.options.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = chevrons[indexPath.section].title
        return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        chevrons[indexPath.section].isOpened.toggle()
        tableView.reloadSections([indexPath.section], with: .none)
    }
}

