//
//  UsersTableViewController.swift
//  A3Test
//
//  Created by Александр Сахнюков on 13/09/2018.
//  Copyright © 2018 Александр Сахнюков. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    var usersForTable:[User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewWillAppear(true)

    }

    //  Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  usersForTable.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromUserToPhoto", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) 
        let cellItem = usersForTable[indexPath.row]
        cell.textLabel?.text = cellItem.name
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "fromUserToPhoto" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = usersForTable[indexPath.row]
                let dvc = segue.destination as! PhotosTableViewController
                dvc.usersForPhotos = object
            }
        }
    }
    
    
    
    
    func getUsers() {
      let urlString = "https://jsonplaceholder.typicode.com/users"
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
 
            guard let data = data else {return}
            guard  error == nil else {
                print((error?.localizedDescription)!)
                return}
        do {
        let users = try JSONDecoder().decode(Array<User>.self, from: data)
        for object in users {
        self.usersForTable.append(object)}
            DispatchQueue.main.async  {
            self.tableView.reloadData()}
        } catch let error {print(error)}
            }.resume()
           
        }
    }
}
