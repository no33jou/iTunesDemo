//
//  MusicCell.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/3.
//

import Foundation
import UIKit

protocol MusicCellViewModel{
    var imageUrl:URL? { get }
    var title:String? { get }
    var detail:String? { get }
    
}
class MusicCell: UITableViewCell, NibFromClassNameble{
    var viewModel:MusicCellViewModel?{
        didSet{
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
