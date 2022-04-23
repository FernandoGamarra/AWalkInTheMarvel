//
//  vcCharacterDetails.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 20/4/22.
//

import UIKit

class vcCharacterDetails: UIViewController {
    
    let TBL_SECTION_DETAILS_GENERAL      = 0
    let TBL_SECTION_DETAILS_COMICS       = 1
    let TBL_SECTION_DETAILS_SERIES       = 2
    let TBL_SECTION_DETAILS_STORIES      = 3
    let TBL_SECTION_DETAILS_EVENTS       = 4

    @IBOutlet weak var tableDetails: UITableView!
    
    let cellCharacterDetailsGeneral: String = "CharacterDetailsGeneralCell"
    let cellCharacterDetailsComics: String = "CharacterDetailsItemsCell"
    let cellCharacterDetailsSeries: String = "CharacterDetailsItemsCell"
    let cellCharacterDetailsStories: String = "CharacterDetailsItemsCell"
    let cellCharacterDetailsEvents: String = "CharacterDetailsItemsCell"
    
    var viewModel: vmCharacterDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initNavigationBar()
        initializations()

    }
 
    func initializations() {
        
        initView()

        let controller = self.navigationController?.previousViewController as? vcTableCharacters
        controller!.fSelectedCharacter = { [self] idCharacter, imgCharacter in
            print("Data received from Block is: ID[\(idCharacter)]  -  IMG[\(imgCharacter)]")
            
            initViewModel(id: idCharacter, img: imgCharacter)
        }
        
    }
 
    func initView() {
        
        self.view.layer.backgroundColor = UIColor.white.cgColor
        
        tableDetails.delegate = self
        tableDetails.dataSource = self
        tableDetails.backgroundColor = .clear
        tableDetails.separatorColor = .black
        tableDetails.separatorStyle = .none
        tableDetails.tableFooterView = UIView()
        tableDetails.allowsSelection = true
        
        let cell: UINib = UINib(nibName: cellCharacterDetailsGeneral, bundle: nil)
        tableDetails.register(cell, forCellReuseIdentifier: cellCharacterDetailsGeneral)
        let cellComics: UINib = UINib(nibName: cellCharacterDetailsComics, bundle: nil)
        tableDetails.register(cellComics, forCellReuseIdentifier: cellCharacterDetailsComics)
        let cellSeries: UINib = UINib(nibName: cellCharacterDetailsSeries, bundle: nil)
        tableDetails.register(cellSeries, forCellReuseIdentifier: cellCharacterDetailsSeries)
        let cellStories: UINib = UINib(nibName: cellCharacterDetailsStories, bundle: nil)
        tableDetails.register(cellStories, forCellReuseIdentifier: cellCharacterDetailsStories)
        let cellEvents: UINib = UINib(nibName: cellCharacterDetailsEvents, bundle: nil)
        tableDetails.register(cellEvents, forCellReuseIdentifier: cellCharacterDetailsEvents)
        
    }
    
    func initViewModel(id: Int, img: UIImage) {
        
        UtilsUI.showWaitControl(wait_title: "Loading character details...")
        
        viewModel = vmCharacterDetails(idCharacter: id, image: img)
        
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.tableDetails.reloadData()
            }
        }
        
    }

    
    func initNavigationBar() {
        
        // TODO: Common source (a)
        
        self.view.backgroundColor = UIColor.white
        
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
