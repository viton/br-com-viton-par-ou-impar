//
//  ChooseFriendViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import Foundation
import FBSDKShareKit

protocol ChooseFriendsDelegate {
    
    func didSelectFriend(friend: User)
    
}

class ChooseFriendViewController: BaseViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var tableManager:BaseTableViewManager?
    var noFriendsPlaceholder:Placeholder?
    var delegate:ChooseFriendsDelegate?
    var friends:Array<User>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics
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
        let text = textField.text
        if text!.characters.count == 0 {
            //reset search
            tableManager?.updateWithData(friends!)
        }else {
            //FILTER and update table
            let filteredFriends = filterFriends(text!)
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
    
    func inviteFriends() {
        let content = FBSDKAppInviteContent()

        content.appLinkURL = NSURL(string: AppSettingsProvider.getAppStoreURL())
        //optionally set previewImageURL
        content.appInvitePreviewImageURL = NSURL(string: AppSettingsProvider.getAppImageURL())
        
        // present the dialog. Assumes self implements protocol `FBSDKAppInviteDialogDelegate`
        FBSDKAppInviteDialog.showWithContent(content, delegate: self)
    }
    
    override func didClickPlaceholderAction(placeholder: Placeholder) {
        super.didClickPlaceholderAction(placeholder)
        if placeholder == noFriendsPlaceholder {
            inviteFriends()
        }
    }
    
}

//MARK: FriendTableViewManagerDelegate
extension ChooseFriendViewController: FriendTableViewManagerDelegate {
    
    func didSelectInviteMoreFriends() {
        inviteFriends()
    }
    
    override func didSelectObject(object:AnyObject) {
        let friend = object as! User
        if let chooseFriendDelegate = delegate {
            chooseFriendDelegate.didSelectFriend(friend)
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
        noFriendsPlaceholder = view.addPlaceholder(Messages.message("choose.friend.placeholder.empty.friends.title"), content: Messages.message("choose.friend.placeholder.empty.friends.disclaimer"), buttonTitle: Messages.message("choose.friend.placeholder.empty.friends.button.title"), image: UIImage(named:"img-invite-friends"))
        noFriendsPlaceholder?.delegate = self
    }
    
    override func prepareToRespose() {
        super.prepareToRespose()
        view.stopLoading()
        view.removePlaceholder(&noFriendsPlaceholder)
    }
    
}

extension ChooseFriendViewController:FBSDKAppInviteDialogDelegate {
    
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        dismissViewControllerAnimated(true, completion: {})
    }
    
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: NSError!) {
        dismissViewControllerAnimated(true, completion: {})
    }
    
}