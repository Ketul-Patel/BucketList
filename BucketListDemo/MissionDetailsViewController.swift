//
//  MissionDetailsViewController.swift
//  BucketListDemo
//
//  Created by Ketul Patel on 6/16/15.
//  Copyright (c) 2015 Ketul Patel. All rights reserved.
//

import UIKit
class MissionDetailsViewController: UITableViewController {
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var delegate: MissionDetailsViewControllerDelegate?
    var missionToEdit: Mission?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newMissionTextField.text = missionToEdit?.objective
    }
    
    @IBOutlet weak var newMissionTextField: UITextField!
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        if let mission = missionToEdit {
            mission.objective = newMissionTextField.text!
            delegate?.missionDetailsViewController(self, didFinishEditingMission: mission)
        } else {
            let mission = Mission(obj: newMissionTextField.text!)
            delegate?.missionDetailsViewController(self, didFinishAddingMission: mission.objective)
        }
    }
}
