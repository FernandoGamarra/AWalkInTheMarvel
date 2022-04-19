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

        initNavigationBar()
        
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
        table.backgroundColor = Colors.AppBackground
        table.separatorColor = .black
        table.separatorStyle = .singleLine
        table.tableFooterView = UIView()
        table.allowsSelection = true
        
//        table.estimatedRowHeight = 130.0
//        table.rowHeight = UITableView.automaticDimension

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
        
        viewModel.reloadCell = { [weak self] index in
            DispatchQueue.main.async {
                self?.table.reloadRows(at: [index], with: .automatic)
            }
        }
    }
    
    func initNavigationBar() {
        
        self.view.backgroundColor = Colors.AppBackground
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.NavBar
        
        let logo: UIImage? = UIImage(named: "MarvelLogo")
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 60, height: 15))
        let imageView = UIImageView(frame: rect)
        imageView.image = logo
        imageView.contentMode = .scaleAspectFit

        let titleView = UIView(frame: CGRect(x:0, y: 0, width: 60, height: 15))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
         
        self.navigationItem.titleView = imageView
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
}
