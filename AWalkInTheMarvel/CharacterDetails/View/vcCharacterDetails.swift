//
//  vcCharacterDetails.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 20/4/22.
//

import UIKit

class vcCharacterDetails: UIViewController {

    @IBOutlet weak var tableDetails: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        

    }
 
    func initializations() {

        let controller = self.navigationController?.previousViewController as? vcTableCharacters
        controller!.fSelectedCharacter = { idCharacter, imgCharacter in
            print("Data received from Block is: ID[\(idCharacter)]  -  IMG[\(imgCharacter)]")
        }
        
    }
 
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
