//
//  ViewController.swift
//  BucketListDemo
//
//  Created by Ketul Patel on 6/16/15.
//  Copyright (c) 2015 Ketul Patel. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, CancelButtonDelegate, MissionDetailsViewControllerDelegate {
    
    var missions: [Mission] = Mission.all()
    var isEditing: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        missions = Mission.all()
        return missions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dequeued: AnyObject = tableView.dequeueReusableCellWithIdentifier("MissionCell", forIndexPath: indexPath)
        
        let cell = dequeued as! UITableViewCell
        
        cell.textLabel?.text = missions[indexPath.row].objective
        
        return cell
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        isEditing = true
        performSegueWithIdentifier("DetailsSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    @IBAction func addMissionButtonPressed(sender: UIBarButtonItem) {
        isEditing = false
        performSegueWithIdentifier("DetailsSegue", sender: nil)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        missions[indexPath.row].destroy()
        missions.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String) {
        dismissViewControllerAnimated(true, completion: nil)
        let mission = Mission(obj: mission)
        mission.save()
        tableView.reloadData()
    }
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: Mission) {
        dismissViewControllerAnimated(true, completion: nil)
        mission.save()
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailsSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! MissionDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            if isEditing! == true {
                if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                    controller.missionToEdit = missions[indexPath.row]
                }
            }
        }
    }

}

