//
//  vcCharacterDetails.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 20/4/22.
//

import UIKit

class vcCharacterDetails: UIViewController {

    @IBOutlet weak var tableDetails: UITableView!
    
    var viewModel: vmCharacterDetails!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initNavigationBar()
        initializations()

    }
 
    func initializations() {

        let controller = self.navigationController?.previousViewController as? vcTableCharacters
        controller!.fSelectedCharacter = { [self] idCharacter, imgCharacter in
            print("Data received from Block is: ID[\(idCharacter)]  -  IMG[\(imgCharacter)]")
            
            initView()
            
            initViewModel(id: idCharacter, img: imgCharacter)
            
        }
        
    }
 
    func initView() {
        
        
    }
    
    func initViewModel(id: Int, img: UIImage) {
        viewModel = vmCharacterDetails(idCharacter: id, image: img)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
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
    
}
