//
//  SettingsVC.swift
//  SpaceX-Rockets
//
//  Created by Pavel on 24.08.22.
//

import UIKit


protocol SettingsVCDelegate: NSObjectProtocol {
    func updateViews(with rocket: Rocket)
}

class SettingsVC: UIViewController {
    
    var rocket: Rocket?
    weak var delegate: SettingsVCDelegate?
    
    @IBOutlet weak var heightSwitch: UISegmentedControl!
    @IBOutlet weak var diameterSwitch: UISegmentedControl!
    @IBOutlet weak var massSwitch: UISegmentedControl!
    @IBOutlet weak var payloadSwitch: UISegmentedControl!
    
    @IBAction func toggleMetricSystem(_ sender: UISegmentedControl) {
        switch(sender) {
        case heightSwitch:
            rocket?.height.toggleSystem()
        case diameterSwitch:
            rocket?.diameter.toggleSystem()
        case massSwitch:
            rocket?.mass.toggleSystem()
        case payloadSwitch:
            rocket?.payloadWeights.forEach {$0.toggleSystem()}
        default:
            print("default case in toggleMetricSystem")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if rocket != nil {
            updateSwitches(rocket!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let delegate = delegate {
            delegate.updateViews(with: rocket!)
        }
    }
    
    func updateSwitches(_ rocket: Rocket){
        updateSwitch(heightSwitch, rocket.height)
        updateSwitch(diameterSwitch, rocket.diameter)
        updateSwitch(massSwitch, rocket.mass)
        updateSwitch(payloadSwitch, rocket.payloadWeights[0])
    }
    
    func updateSwitch(_ control: UISegmentedControl, _ useMetric: MetricOrImperialSystem) {
        control.selectedSegmentIndex = useMetric.metricSystem() ? 0 : 1
    }
        
    @IBAction func closeButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}
