//
//  MissionDetailsViewControllerDelegate.swift
//  BucketListDemo
//
//  Created by Ketul Patel on 6/16/15.
//  Copyright (c) 2015 Ketul Patel. All rights reserved.
//

import UIKit
protocol MissionDetailsViewControllerDelegate: class {
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String)
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: Mission)
}
