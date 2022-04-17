//
//  vcTableCharacters.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 15/4/22.
//

import UIKit

class vcTableCharacters: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    let cellCharacter: String = "CharacterCell"
    
    lazy var viewModel = {
        vmCharacters()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializations()
        
        // Do any additional setup after loading the view.
    }

    func initializations() {
        initView()
        initViewModel()
    }
    
    func initView() {
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
        table.separatorColor = .black
        table.separatorStyle = .singleLine
        table.tableFooterView = UIView()
        table.allowsSelection = false

        let cell: UINib = UINib(nibName: cellCharacter, bundle: nil)
        table.register(cell, forCellReuseIdentifier: cellCharacter)
    }
    
    func initViewModel() {
        viewModel.getCharacters()
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
            
        }
    }
}
