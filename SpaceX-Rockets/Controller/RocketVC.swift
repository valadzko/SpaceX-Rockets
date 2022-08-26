//
//  RocketVC.swift
//  SpaceX-Rockets
//
//  Created by Pavel on 22.08.22.
//

import UIKit

class RocketVC: UIViewController {
    @IBOutlet weak var rockerInfoView: UIView!
    
    // All the UI outlets
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var firstLaunchDateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var launchCostLabel: UILabel!
    // first stage
    @IBOutlet weak var engines1Label: UILabel!
    @IBOutlet weak var fuelAmount1Label: UILabel!
    @IBOutlet weak var burndownTime1Label: UILabel!
    // second stage
    @IBOutlet weak var engines2Label: UILabel!
    @IBOutlet weak var fuelAmount2Label: UILabel!
    @IBOutlet weak var burndownTime2Label: UILabel!
    // horizontal views info
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var payloadLabel: UILabel!
    
    lazy var rocket = Rocket.example()
    
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smallDesignChangesForViews()
        
        // query data from API
        APIManager.GetRocket { rocket in
            self.updateViews(with: rocket)
        }
        //updateViews(with: rocket)
    }
    
    func smallDesignChangesForViews() {
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
    
    /*
     TODO - Fix data parsing
     @IBOutlet weak var firstLaunchDateLabel: UILabel!
     */
    
    func updateViews(with rocket: Rocket) {
        rocketNameLabel.text = rocket.name
        countryLabel.text = rocket.country
        //TODO: don't show decimal if round
        launchCostLabel.text = "$\(rocket.costInMillions) млн"

        // first stage
        if let firstStage = rocket.firstStage {
            engines1Label.text = "\(firstStage.engines)"
            fuelAmount1Label.text = "\(firstStage.fuelAmountTons)"
            burndownTime1Label.text = "\(firstStage.burnTimeSEC ?? 0)"
        }
        
        // second stage
        if let secondStage = rocket.firstStage {
            engines2Label.text = "\(secondStage.engines)"
            fuelAmount2Label.text = "\(secondStage.fuelAmountTons)"
            burndownTime2Label.text = "\(secondStage.burnTimeSEC ?? 0)"
        }
        
        massLabel.text = "\(rocket.mass.lb)"
        diameterLabel.text = "\(rocket.diameter.feet)"
        heightLabel.text = "\(rocket.height.feet)"
         
        payloadLabel.text = "\(rocket.totalPayloadLb)"
    }
}
