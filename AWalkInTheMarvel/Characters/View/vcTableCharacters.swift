//
//  vcTableCharacters.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 15/4/22.
//

import UIKit

class vcTableCharacters: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var fieldFilter: TextFieldFloatingPlaceHolder!
    
    let cellCharacter: String = "CharacterCell"
    
    var fSelectedCharacter: ((Int, UIImage)->())?
    
    var mTextSelection: String = ""
    
    lazy var viewModel = {
        vmCharacters()
    }()
    var indexPathSelectedRow: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        
        initializations()
        
        // Do any additional setup after loading the view.
    }

    func initializations() {
        initView()
        initControls()
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
    
    func initControls() {
        fieldFilter.titleColor = .black
        fieldFilter.placeholder = "Filter characters"
        fieldFilter.title = "Find for..."
        fieldFilter.layer.backgroundColor = UIColor.white.cgColor
        fieldFilter.addTarget(self, action: #selector(self.onTextChanged(_:)), for: .editingChanged)
    }
    
    func initNavigationBar() {
        
        // TODO: Common source (a)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        table.deselectAllRows(animated: true)
        indexPathSelectedRow = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if indexPathSelectedRow != nil {
            let currentSelectionCell = table.cellForRow(at: indexPathSelectedRow!) as! CharacterCell
            fSelectedCharacter!(currentSelectionCell.idCharacter, currentSelectionCell.charImage.image!)
        }
    }
    
    // MARK: ITextFieldDelegate
     @objc func onTextChanged(_ textField: UITextField) {
         mTextSelection = textField.text!
         viewModel.filterCharacters(letters: mTextSelection)
     }
}
