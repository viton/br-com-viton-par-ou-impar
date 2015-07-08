//
//  ChooseFriendViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import Foundation

protocol ChooseFriendsDelegate {
    
    func didSelectFriend(friend: User)
    
}

class ChooseFriendViewController: BaseViewController, FriendsCallback {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var tableManager:BaseTableViewManager?
    var noFriendsPlaceholder:Placeholder?
    var delegate:ChooseFriendsDelegate?
    var friends:Array<User>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        modalPresentationStyle = UIModalPresentationStyle.PageSheet
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        requestFriends()
    }
    
    func setup() {
        tableManager = FriendsTableViewManager(tableView: tableView, delegate: self)
        searchField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func textFieldDidChange(textField: UITextField) {
        var text = textField.text
        if count(text) == 0 {
            //reset search
            tableManager?.updateWithData(friends!)
        }else {
            //FILTER and update table
            var filteredFriends = filterFriends(text)
            tableManager?.updateWithData(filteredFriends)
        }
    }
    
    func requestFriends() {
        view.startLoading()
        FriendsProvider.getFriends(self)
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: {})
    }
    
    func filterFriends(filterText:String) -> [User] {
        var filteredFriends = Array<User>()
        for friend in friends! {
            if friend.name?.uppercaseString.rangeOfString(filterText.uppercaseString) != nil {
                filteredFriends.append(friend)
            }
        }
        return filteredFriends
    }
    
    override func didSelectObject(object:AnyObject) {
        let friend = object as! User
        if let chooseFriendDelegate = delegate {
            chooseFriendDelegate.didSelectFriend(friend)
        }
    }
    
}

//MARK: PlaceholderActionDelegate
extension ChooseFriendViewController: PlaceholderActionDelegate {
    
    override func didClickPlaceholderAction(placeholder: Placeholder) {
        super.didClickPlaceholderAction(placeholder)
        if placeholder == noFriendsPlaceholder {
            println("Should call friends and create example game")
        }
    }
    
}

//MARK: FriendsCallback
extension ChooseFriendViewController:FriendsCallback {
    
    func onSuccess(friends:Array<User>) {
        self.friends = friends
        tableManager?.updateWithData(friends)
    }
    
    func onEmptyFriends() {
        noFriendsPlaceholder = view.addPlaceholder("I can't believe", content: "You got no friends playing. While we create a game example for you, call your friends to play with you", buttonTitle: "Play game and invite friends", image: nil)
        noFriendsPlaceholder?.delegate = self
    }
    
    override func prepareToRespose() {
        super.prepareToRespose()
        view.stopLoading()
        view.removePlaceholder(&noFriendsPlaceholder)
    }
    
}