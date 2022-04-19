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
        
        let navController = navigationController!
        
        let logo = UIImage(named: "MarvelLogo")
        let imageView = UIImageView(image: logo)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - (logo?.size.width)! / 3
        let bannerY = bannerHeight / 2 - (logo?.size.height)! / 3
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = imageView
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
}
