//
//  GameTableViewManager.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

protocol GameTableViewManagerDelegate {
    
    func didSelectGameToReply(game:Game)
    
    func didSelectFinishGame(game:Game)
    
    func onPullToRefresh()
    
}

class GameTableViewManager: BaseTableViewManager {
    
    var gameTableDelegate:GameTableViewManagerDelegate?
    var refreshControl:UIRefreshControl!
    
    override init(tableView: UITableView, delegate: BaseTableViewManagerDelegate) {
        gameTableDelegate = delegate as? GameTableViewManagerDelegate
        refreshControl = UIRefreshControl()
        super.init(tableView: tableView, delegate: delegate)
        refreshControl.addTarget(self, action: "shouldRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func stopRefreshControl() {
        refreshControl.endRefreshing()
    }
    
    func shouldRefresh(){
        gameTableDelegate?.onPullToRefresh()
    }
    
    override func setData(item: AnyObject, toCell cell: UITableViewCell) {
        if let gameCell = cell as? GameTableViewCell {
            let game = item as! Game
            gameCell.betTextLabel.text = game.betText
            let oponent = game.getOponent()
            gameCell.nameLabel.text = oponent.name
            gameCell.imageUser.setImage(url: oponent.profileImage!)
            gameCell.imageUser.circle()
            gameCell.statusLabel.text = game.getStatus()
            gameCell.dateLabel.text = game.date!.getReadableDate()
            gameCell.notificationView.hidden = game.finish!.boolValue || game.amIOwner()
            gameCell.notificationView.circle()
            gameCell.backgroundColor = UIColor.clearColor()
            if game.finish!.boolValue && game.isVisualized() {
                if game.amIWinner() {
                    gameCell.gameResultImage.image = UIImage(named: "ic-win")
                }else {
                    gameCell.gameResultImage.image = UIImage(named: "ic-loose")
                }
            }else {
                gameCell.gameResultImage.image = nil
                if !game.amIOwner() {
                    gameCell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
                }
            }
        }
    }
    
    override func cellClasses() -> Array<AnyClass> {
        return [GameTableViewCell.classForCoder()]
    }
    
    func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject) -> Bool {
        
        
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let game = data![indexPath.row] as! Game
        if game.finish!.boolValue == true {
            gameTableDelegate?.didSelectFinishGame(game)
        }else if(game.owner! != LoginProvider.user!.facebookId!) {
            gameTableDelegate?.didSelectGameToReply(game)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
    
}
