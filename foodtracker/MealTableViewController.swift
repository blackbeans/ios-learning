//
//  MealTableViewController.swift
//  foodtracker
//
//  Created by blackbeans on 7/17/15.
//  Copyright (c) 2015 blackbeans. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        if let saveMeals =  loadMeals(){
            meals += saveMeals
        }
        
      
    }
    
    func loadMeals()->[Meal]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.archivepath)as? [Meal]
    }
    
    func saveMeals(){
        let isSuccSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.archivepath)
        if !isSuccSave{
            print("save meals fail!")
        }
    }
    
    
//    func loadMeals(){
//        let meal1 = Meal(name: "meal_1", photo: UIImage(named: "meal_1.jpg")!, rating: 4)!
//        let meal2 = Meal(name: "meal_2", photo: UIImage(named: "meal_2.jpg")!, rating: 3)!
//        let meal3 = Meal(name: "meal_3", photo: UIImage(named: "meal_3.jpg")!, rating: 5)!
//        
//        
//        meals+=[meal1,meal2,meal3]
//    
//    }
//    
    
    
    @IBAction func unwindToMealList(sender : UIStoryboardSegue){
        
        if let sourceViewController = sender.sourceViewController as? MealViewController{
            let meal = sourceViewController.meal
            
            if let selectIndexPath = tableView.indexPathForSelectedRow(){
                //update
                meals[selectIndexPath.row]=meal!
                tableView.reloadRowsAtIndexPaths([selectIndexPath], withRowAnimation: UITableViewRowAnimation.None)
            }else{
                //add
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                meals.append(meal!)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
                
            }
            
            saveMeals()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return meals.count
    }
    
    


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell

         //Configure the cell...

        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.ratingControl.rating = meal.rating
        cell.photoImageView.image = meal.photo
        
        return cell
    }


    /*
     Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
         Return NO if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            
            saveMeals()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert{
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail"{
            
             let mvc = segue.destinationViewController as? MealViewController
            
                if let selectedMealCell = sender as? MealTableViewCell{
                    let indexPath = tableView.indexPathForCell(selectedMealCell)!
                    let selectMeal = meals[indexPath.row]
                    mvc?.meal=selectMeal
                
            }
        
        }else if segue.identifier == "AddItem"{
            
            print("add new meal ")
            
        }
    }


}
