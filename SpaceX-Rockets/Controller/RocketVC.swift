//
//  RocketVC.swift
//  SpaceX-Rockets
//
//  Created by Pavel on 22.08.22.
//

import UIKit

class RocketVC: UIViewController, SettingsVCDelegate {
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
    @IBOutlet weak var heightMeasurementLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var diameterMeasurementsLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var massMeasurementsLabel: UILabel!
    @IBOutlet weak var payloadLabel: UILabel!
    @IBOutlet weak var payloadMeasurementsLabel: UILabel!
    
    //var rocket = Rocket.example()
    lazy var rocket: Rocket? = nil
    
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        nextViewController.rocket = rocket
        nextViewController.delegate = self
        self.present(nextViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smallDesignChangesForViews()
        
        // query data from API
        APIManager.GetRocket { rocket in
            self.rocket = rocket
        }
        
        if let rocket = rocket {
            print("updated views from viewDidLoad")
            updateViews(with: rocket)
        }
    }
    
    func smallDesignChangesForViews() {
        rockerInfoView.layer.cornerRadius = 40
        rockerInfoView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("in viewDidAppear")
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if let rocket = rocket {
            
            self.updateViews(with: rocket)
        }
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
        launchCostLabel.text = "$\(rocket.launchCostMln) млн"

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
        
        heightLabel.text = "\(rocket.height.value())"
        diameterLabel.text = "\(rocket.diameter.value())"
        massLabel.text = "\(rocket.mass.value())"
        payloadLabel.text = "\(rocket.totalPayload)"
        
        heightMeasurementLabel.text = "Высота,\(rocket.height.measurementName())"
        diameterMeasurementsLabel.text = "Диаметр,\(rocket.diameter.measurementName())"
        massMeasurementsLabel.text = "Масса,\(rocket.mass.measurementName())"
        payloadMeasurementsLabel.text = "Нагрузка,\(rocket.payloadWeights[0].measurementName())"
    }
}
