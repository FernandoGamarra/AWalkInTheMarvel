//
//  vcCharacterDetails.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 20/4/22.
//

import UIKit

class vcCharacterDetails: UIViewController {
    
    
    @IBOutlet weak var viewContainer: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initializeView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func initializeView() {
        
        self.view.backgroundColor = UIColor(white: 0.5, alpha: 0.9)
        
        viewContainer.layer.cornerRadius = 12
        viewContainer.layer.backgroundColor = Colors.AppBackground.cgColor
        
    }
    
}
