//
//  ViewController.swift
//  SpaceX-Rockets
//
//  Created by Pavel on 22.08.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rockerInfoView: UIView!
    
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rockerInfoView.layer.cornerRadius = 40
        rockerInfoView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
