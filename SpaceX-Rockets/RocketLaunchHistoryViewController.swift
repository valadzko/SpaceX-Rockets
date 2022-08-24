//
//  RocketLaunchHistoryViewController.swift
//  SpaceX-Rockets
//
//  Created by Pavel on 24.08.22.
//

import UIKit

class RocketLaunchHistoryViewController: UIViewController {
    
    @IBOutlet weak var reverseRocketImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        reverseRocketImageView.transform = CGAffineTransform(scaleX: -1, y: -1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
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
